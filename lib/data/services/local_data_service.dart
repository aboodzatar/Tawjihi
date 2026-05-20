import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../models/bilingual_text.dart';

class LocalDataService extends GetxService {
  // Original raw data (for reference if needed)
  Map<String, dynamic>? _rawDataset;
  
  // Optimized memory structures
  final Map<String, UniversityData> universities = {};
  final Map<String, TrackData> tracks = {};
  final List<StudentMockData> students = [];

  // Initialize and parse data
  Future<LocalDataService> init() async {
    await _loadDataset();
    _initializeMockStudents();
    return this;
  }

  Future<void> _loadDataset() async {
    try {
      final String response = await rootBundle.loadString(
          'lib/data/jordan_education_dataset_bilingual_grouped_by_university_year.json');
      _rawDataset = json.decode(response);

      // Parse Tracks
      final trackMap = _rawDataset!['track_mapping'] as Map<String, dynamic>;
      trackMap.forEach((key, value) {
        tracks[key] = TrackData(
          id: key,
          nameAr: value['name_ar'],
          nameEn: value['name_en'],
        );
      });

      // Parse Universities and group Majors by ID across years
      final uniList = _rawDataset!['universities'] as List;
      for (var uniJson in uniList) {
        final uniId = uniJson['university_id'];
        final university = UniversityData(
          id: uniId,
          nameAr: uniJson['name_ar'],
          nameEn: uniJson['name_en'],
          type: uniJson['type'],
          region: uniJson['region'],
        );

        // Map to group majors by their unique ID to avoid duplicates
        final Map<String, MajorData> majorGroups = {};

        final yearsMap = uniJson['years'] as Map<String, dynamic>;
        yearsMap.forEach((yearStr, yearData) {
          final int year = int.parse(yearStr);
          final majorsList = yearData['majors'] as List;

          for (var majorJson in majorsList) {
            final String majorId = majorJson['major_id'];
            
            if (!majorGroups.containsKey(majorId)) {
              majorGroups[majorId] = MajorData(
                id: majorId,
                nameAr: majorJson['major_name_ar'],
                nameEn: majorJson['major_name_en'],
                facultyAr: majorJson['faculty_name_ar'],
                facultyEn: majorJson['faculty_name_en'],
                trackId: majorJson['track_id'],
                acceptedBranchAr: majorJson['accepted_branch_ar'],
                acceptedBranchEn: majorJson['accepted_branch_en'],
              );
            }

            // Data Swap Logic: JSON has Mowazi > Tanafos, but logically Tanafos > Mowazi in Jordan.
            // We swap them here so the rest of the app logic (prediction, filters, UI) works correctly.
            double rawTanafos = (majorJson['min_grade_tanafos'] as num).toDouble();
            double? rawMowazi = majorJson['min_grade_mowazi'] is num 
                ? (majorJson['min_grade_mowazi'] as num).toDouble() 
                : null;

            majorGroups[majorId]!.yearlyData[year] = AdmissionStats(
              year: year,
              minTanafos: rawMowazi ?? rawTanafos, // Competitive grade (higher)
              minMowazi: rawTanafos,                // Paid grade (lower)
              acceptedCount: majorJson['accepted_students'] as int,
            );
          }
        });

        university.majors.addAll(majorGroups.values);
        universities[uniId] = university;
      }

      print("Data loaded successfully: ${universities.length} universities processed.");
    } catch (e) {
      print("Error loading local dataset: $e");
    }
  }

  void _initializeMockStudents() {
    // IT Track
    students.add(StudentMockData(id: "IT-001", nameAr: "عمر خالد", nameEn: "Omar Khaled", grade: 97.5, trackId: "track_it"));
    students.add(StudentMockData(id: "IT-002", nameAr: "نور علي", nameEn: "Noor Ali", grade: 82.3, trackId: "track_it"));

    // Engineering Track
    students.add(StudentMockData(id: "ENG-001", nameAr: "زيد محمد", nameEn: "Zaid Mohamed", grade: 98.2, trackId: "track_eng"));
    students.add(StudentMockData(id: "ENG-002", nameAr: "رشا يوسف", nameEn: "Rasha Youssef", grade: 85.5, trackId: "track_eng"));

    // Health Track
    students.add(StudentMockData(id: "MED-001", nameAr: "عبدالله أحمد", nameEn: "Abdullah Ahmed", grade: 99.8, trackId: "track_health"));
    students.add(StudentMockData(id: "MED-002", nameAr: "دينا محمود", nameEn: "Dina Mahmoud", grade: 88.0, trackId: "track_health"));

    // Science
    students.add(StudentMockData(id: "SCI-001", nameAr: "باسل سمير", nameEn: "Basil Samir", grade: 94.0, trackId: "track_science"));
    students.add(StudentMockData(id: "SCI-002", nameAr: "سلمى وليد", nameEn: "Salma Walid", grade: 76.5, trackId: "track_science"));

    // Business Track
    students.add(StudentMockData(id: "BIZ-001", nameAr: "كريم حسن", nameEn: "Karim Hassan", grade: 93.5, trackId: "track_business"));
    students.add(StudentMockData(id: "BIZ-002", nameAr: "مريم إبراهيم", nameEn: "Maryam Ibrahim", grade: 72.0, trackId: "track_business"));
    
    // Humanities
    students.add(StudentMockData(id: "HUM-001", nameAr: "فادي غسان", nameEn: "Fadi Ghassan", grade: 89.0, trackId: "track_humanities"));
    students.add(StudentMockData(id: "HUM-002", nameAr: "عبير صبحي", nameEn: "Abeer Sobhi", grade: 68.5, trackId: "track_humanities"));

    // Law
    students.add(StudentMockData(id: "LAW-001", nameAr: "جاد عدنان", nameEn: "Jad Adnan", grade: 96.0, trackId: "track_law"));
    students.add(StudentMockData(id: "LAW-002", nameAr: "ليان قاسم", nameEn: "Layan Qasim", grade: 75.0, trackId: "track_law"));

    // Education
    students.add(StudentMockData(id: "EDU-001", nameAr: "رامي منير", nameEn: "Rami Mounir", grade: 85.0, trackId: "track_edu"));
    students.add(StudentMockData(id: "EDU-002", nameAr: "سهى نبيل", nameEn: "Soha Nabil", grade: 66.0, trackId: "track_edu"));
  }

  // --- Search & Filter Methods ---

  StudentMockData? findStudentById(String id) {
    return students.firstWhereOrNull((s) => s.id == id);
  }

  List<MajorData> getEligibleMajors(double studentGrade, String studentTrackId) {
    final List<MajorData> eligible = [];
    
    for (var uni in universities.values) {
      for (var major in uni.majors) {
        // Filter by Track
        if (major.trackId != studentTrackId) continue;

        // Get latest year data (2025)
        final latestData = major.yearlyData[2025];
        if (latestData != null && studentGrade >= latestData.minTanafos) {
          eligible.add(major);
        }
      }
    }
    return eligible;
  }

  List<UniversityData> getAllUniversities() => universities.values.toList();
  
  TrackData? getTrack(String id) => tracks[id];

  /// Finds a major by its combined ID (e.g., "the-university-of-jordan-history")
  MajorData? findMajorByCombinedId(String combinedId) {
    for (var uni in universities.values) {
      for (var major in uni.majors) {
        if ("${uni.id}-${major.id}" == combinedId) {
          return major;
        }
      }
    }
    return null;
  }

  UniversityData? findUniversityOfMajor(String majorId) {
    for (var uni in universities.values) {
      if (uni.majors.any((m) => m.id == majorId)) return uni;
    }
    return null;
  }
}

// --- Internal Models for the Service ---

class UniversityData {
  final String id;
  final String nameAr;
  final String nameEn;
  final String type;
  final String region;
  final List<MajorData> majors = [];

  UniversityData({required this.id, required this.nameAr, required this.nameEn, required this.type, required this.region});
}

class MajorData {
  final String id;
  final String nameAr;
  final String nameEn;
  final String facultyAr;
  final String facultyEn;
  final String trackId;
  final String acceptedBranchAr;
  final String acceptedBranchEn;
  final Map<int, AdmissionStats> yearlyData = {}; // year -> data

  MajorData({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.facultyAr,
    required this.facultyEn,
    required this.trackId,
    required this.acceptedBranchAr,
    required this.acceptedBranchEn,
  });
}

class AdmissionStats {
  final int year;
  final double minTanafos;
  final double? minMowazi;
  final int acceptedCount;

  AdmissionStats({required this.year, required this.minTanafos, this.minMowazi, required this.acceptedCount});
}

class TrackData {
  final String id;
  final String nameAr;
  final String nameEn;

  TrackData({required this.id, required this.nameAr, required this.nameEn});
}

class StudentMockData {
  final String id;
  final String nameAr;
  final String nameEn;
  final double grade;
  final String trackId;

  StudentMockData({required this.id, required this.nameAr, required this.nameEn, required this.grade, required this.trackId});
}
