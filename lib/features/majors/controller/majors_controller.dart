import 'package:get/get.dart';
import '../../../data/services/local_data_service.dart';
import '../../../data/models/major_model.dart';
import '../../../data/models/bilingual_text.dart';
import '../../auth/controller/auth_controller.dart';
import '../../../core/utils/prediction_engine.dart';
import '../../../core/utils/shared_prefs_helper.dart';
import '../../profile/controller/profile_controller.dart';
import '../../../data/models/student_preferences_model.dart';
import '../../../data/mock/track_enrichment_data.dart';

class MajorsController extends GetxController {
  static MajorsController get to => Get.find<MajorsController>();

  // Maps our governorate keys to dataset 'region' values
  static const Map<String, String> _govToRegion = {
    "gov_amman":   "middle",
    "gov_zarqa":   "middle",
    "gov_balqa":   "middle",
    "gov_madaba":  "middle",
    "gov_irbid":   "north",
    "gov_mafraq":  "north",
    "gov_jerash":  "north",
    "gov_ajloun":  "north",
    "gov_karak":   "south",
    "gov_tafila":  "south",
    "gov_maan":    "south",
    "gov_aqaba":   "south",
  };

  final _localData = Get.find<LocalDataService>();

  final majorsList = <MajorModel>[].obs;
  
  // Local Filtering logic
  final searchQuery = "".obs;
  final selectedType = "All".obs;
  final selectedGov = "All".obs;
  final selectedChance = "All".obs;
  final selectedProgram = "All".obs;
  final selectedTrack = "All".obs;

  List<MajorModel> get filteredMajors {
    return majorsList.where((major) {
      final query = searchQuery.value.toLowerCase();
      final matchesSearch = query.isEmpty || 
          major.name.ar.toLowerCase().contains(query) || 
          major.name.en.toLowerCase().contains(query) || 
          major.university.ar.toLowerCase().contains(query) ||
          major.university.en.toLowerCase().contains(query);
      
      bool matchesType = true;
      if (selectedType.value != "All") {
        final isPublicRequested = selectedType.value == "pt_public";
        final typeLower = major.universityType.toLowerCase();
        matchesType = isPublicRequested ? typeLower.contains("public") : typeLower.contains("private");
      } else {
        // When filter is "All", we still respect profile preferences by default
        if (Get.isRegistered<ProfileController>()) {
          final profile = Get.find<ProfileController>();
          final prefTypes = profile.selectedProgramTypes;
          if (prefTypes.isNotEmpty) {
            final typeLower = major.universityType.toLowerCase();
            final canShowPublic = prefTypes.contains("pt_public");
            final canShowPrivate = prefTypes.contains("pt_private");
            
            if (typeLower.contains("public") && !canShowPublic) matchesType = false;
            if (typeLower.contains("private") && !canShowPrivate) matchesType = false;
          }
        }
      }

      final matchesTrack = selectedTrack.value == "All" || 
          major.trackTags.any((t) => t.toLowerCase() == selectedTrack.value.toLowerCase());

      final matchesChance = selectedChance.value == "All" ||
          major.predictedChance.toLowerCase() == selectedChance.value.toLowerCase() ||
          (selectedChance.value.toLowerCase() == "chance_safe" && (major.predictedChance.toLowerCase() == "safe" || major.predictedChance.toLowerCase() == "high")) ||
          (selectedChance.value.toLowerCase() == "chance_high" && major.predictedChance.toLowerCase() == "high") ||
          (selectedChance.value.toLowerCase() == "chance_competitive" && major.predictedChance.toLowerCase() == "competitive") ||
          (selectedChance.value.toLowerCase() == "chance_hard" && major.predictedChance.toLowerCase() == "ambitious") ||
          (selectedChance.value.toLowerCase() == "chance_ambitious" && major.predictedChance.toLowerCase() == "ambitious");

      return matchesSearch && matchesType && matchesTrack && matchesChance;
    }).toList();
  }

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Sync filter and reload data whenever profile changes
    if (Get.isRegistered<ProfileController>()) {
      final profile = Get.find<ProfileController>();
      
      _syncFilterWithProfile(profile);
      
      // Update filter when program types change
      ever(profile.selectedProgramTypes, (_) {
        _syncFilterWithProfile(profile);
        loadMajors(); // Force reload data to match new strict filters
      });

      // Reload data when other relevant preferences change
      ever(profile.governorate, (_) => loadMajors());
      ever(profile.canTravel, (_) => loadMajors());
    }

    loadMajors();
    // Re-load majors whenever the student changes (e.g. login/logout)
    ever(AuthController.to.currentStudent, (_) => loadMajors());
  }

  void _syncFilterWithProfile(ProfileController profile) {
    final types = profile.selectedProgramTypes;
    if (types.isEmpty) {
      selectedType.value = "All";
    } else if (types.length == 1) {
      // If user selected only one, set filter to that
      selectedType.value = types.first;
    } else {
      // If user selected both or none specifically, show all
      selectedType.value = "All";
    }
  }

  void loadMajors() {
    isLoading.value = true;
    
    // Sync filter one more time to be safe
    if (Get.isRegistered<ProfileController>()) {
      _syncFilterWithProfile(Get.find<ProfileController>());
    }
    
    final List<MajorModel> allMajors = [];
    final String? studentTrack = AuthController.to.currentStudent.value?.track;

    bool canTravel = true;
    String studentRegion = "";
    List<String> programTypes = [];

    try {
      if (Get.isRegistered<ProfileController>()) {
        final profile = Get.find<ProfileController>();
        canTravel = profile.canTravel.value;
        studentRegion = _govToRegion[profile.governorate.value] ?? "";
        programTypes = profile.selectedProgramTypes.toList();
      } else {
        final userId = AuthController.to.currentStudent.value?.id;
        final localData = userId != null ? SharedPrefsHelper.getPreferences(userId) : null;
        if (localData != null) {
          final prefs = StudentPreferencesModel.fromJson(localData);
          canTravel = prefs.openToOtherGovernorate;
          studentRegion = _govToRegion[prefs.governorate] ?? "";
          programTypes = prefs.programTypes;
        }
      }
    } catch (_) {}
    
    for (var uni in _localData.getAllUniversities()) {
      if (!canTravel && studentRegion.isNotEmpty) {
        if (uni.region.toLowerCase() != studentRegion) {
          continue;
        }
      }

      // STRICT FILTER: Only load universities that match the student's profile preferences
      if (programTypes.isNotEmpty) {
        final bool isPublicSelected = programTypes.contains("pt_public");
        final bool isPrivateSelected = programTypes.contains("pt_private");
        
        final uniType = uni.type.toLowerCase();
        if (uniType == "public" && !isPublicSelected) continue;
        if (uniType == "private" && !isPrivateSelected) continue;
      }

      for (var major in uni.majors) {
        // FILTER: Only show majors for the student's track if logged in
        if (studentTrack != null && major.trackId != studentTrack) {
          continue;
        }
        
        // Map the Local Data Structure to our MajorModel used in UI
        allMajors.add(_mapToMajorModel(uni, major));
      }
    }
    
    majorsList.assignAll(allMajors);
    isLoading.value = false;
  }

  MajorModel mapLocalDataToUI(UniversityData uni, MajorData major) {
    return _mapToMajorModel(uni, major);
  }

  MajorModel _mapToMajorModel(UniversityData uni, MajorData major) {
    final studentGrade = AuthController.to.currentStudent.value?.tawjihiPercentage ?? 50.0;
    final prediction = PredictionEngine.calculatePrediction(major, studentGrade);
    final e = TrackEnrichment.getByTrack(major.trackId);

    return MajorModel(
      id: "${uni.id}-${major.id}",
      name: BilingualText(ar: major.nameAr, en: major.nameEn),
      description: BilingualText(
        ar: "${major.nameAr} في ${uni.nameAr} — ${major.facultyAr}. ${e.suitedPersonality.ar}.",
        en: "${major.nameEn} at ${uni.nameEn} — ${major.facultyEn}. ${e.suitedPersonality.en}.",
      ),
      university: BilingualText(ar: uni.nameAr, en: uni.nameEn),
      location: BilingualText(
        ar: _regionAr(uni.region),
        en: _regionEn(uni.region),
      ),
      universityType: uni.type == 'public' ? 'حكومي / Public' : 'خاص / Private',
      programType: 'عادي / Regular',
      predictedChance: prediction.chance,
      confidenceScore: prediction.confidence,
      historicalAcceptanceData: major.yearlyData.values.map((s) => {
        "year": s.year,
        "minGrade": s.minTanafos,
        "accepted": s.acceptedCount,
      }).toList(),
      trendDirection: prediction.trend,
      predictedTanafos: prediction.predictedTanafos,
      predictedMowazi: prediction.predictedMowazi,
      aiDisclaimer: const BilingualText(
        ar: "هذا المعدل تقريبي بناءً على سنوات سابقة وليس الحد الأدنى الحقيقي للسنة القادمة، تم حسابه بواسطة الذكاء الاصطناعي.",
        en: "AI-generated approximation based on recent years; NOT the official minimum grade for the upcoming year.",
      ),
      duration: 4,
      mainSubjects: e.mainSubjects,
      studyIntensity: e.studyIntensity,
      intensityReason: e.intensityReason,
      difficultyLevel: e.difficultyLevel,
      difficultyReason: e.difficultyReason,
      coreSkills: e.coreSkills,
      certifications: const [],
      suitedPersonality: e.suitedPersonality,
      commonChallenges: e.cons,
      careerPaths: e.careerPaths,
      workEnvironments: e.workEnvironments,
      jobAvailability: e.jobAvailability,
      marketSaturation: e.marketSaturation,
      incomeRange: e.incomeRange,
      incomeGrowth: e.incomeGrowth,
      incomeStability: e.incomeStability,
      mastersSpecializations: e.mastersSpecializations,
      phdPaths: const [],
      fieldSwitchingFlexibility: e.flexibilityScore,
      internationalOpportunities: e.internationalOpportunities,
      pros: e.pros,
      cons: e.cons,
      notSuitableFor: e.notSuitableFor,
      timeToIncome: e.timeToIncome,
      demandVsReturn: e.demandVsReturn,
      flexibilityScore: e.flexibilityScore,
      trackTags: [major.trackId],
      requiredTraits: const [],
      graduateContacts: const [],
    );
  }

  void resetFilters() {
    searchQuery.value = "";
    selectedType.value = "All";
    selectedGov.value = "All";
    selectedChance.value = "All";
    selectedProgram.value = "All";
    selectedTrack.value = "All";
  }

  static String _regionAr(String region) {
    switch (region.toLowerCase()) {
      case 'middle': return 'المنطقة الوسطى';
      case 'north':  return 'المنطقة الشمالية';
      case 'south':  return 'المنطقة الجنوبية';
      default:       return region;
    }
  }

  static String _regionEn(String region) {
    switch (region.toLowerCase()) {
      case 'middle': return 'Central Region';
      case 'north':  return 'Northern Region';
      case 'south':  return 'Southern Region';
      default:       return region;
    }
  }
}
