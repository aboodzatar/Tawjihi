import 'package:get/get.dart';
import 'package:tawjihi_new/features/profile/controller/profile_controller.dart';
import '../../../data/models/major_model.dart';
import '../../../features/majors/controller/majors_controller.dart';
import '../../../core/routes/route_names.dart';
import '../../auth/controller/auth_controller.dart';
import 'questionnaire_controller.dart';

class SuggestedMajorsController extends GetxController {
  final suggestedMajors = <MajorModel>[].obs;
  final isLoading = true.obs;

  // Filters for Suggested Majors
  final selectedChance = "All".obs;

  List<MajorModel> get filteredSuggestedMajors {
    return suggestedMajors.where((major) {
      final matchesChance = selectedChance.value == "All" ||
          major.predictedChance.toLowerCase() == selectedChance.value.toLowerCase() ||
          (selectedChance.value.toLowerCase() == "safe" && major.predictedChance.toLowerCase() == "high") ||
          (selectedChance.value.toLowerCase() == "hard" && major.predictedChance.toLowerCase() == "ambitious");

      return matchesChance;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    
    // Initial run
    runMatching();
    
    // Re-run matching whenever profile preferences change
    if (Get.isRegistered<ProfileController>()) {
      ever(Get.find<ProfileController>().selectedProgramTypes, (_) => runMatching());
    }
  }

  Future<void> runMatching() async {
    await Future.delayed(const Duration(milliseconds: 100));
    isLoading.value = true;
    try {
      final student = AuthController.to.currentStudent.value;
      if (student == null) return;

      final qController = QuestionnaireController.to;
      final answers = qController.answers;
      final questions = qController.questions;

      // 1. Calculate Interest Scores from Questionnaire
      final Map<String, double> interestPoints = {};

      for (var q in questions) {
        final answerKey = answers[q.id];
        if (answerKey == null) continue;

        final option = q.options.firstWhereOrNull((o) => o.key == answerKey);
        if (option == null) continue;

        // Apply boosts based on answer multiplier
        q.majorBoosts.forEach((majorOrTag, points) {
          double boostedPoints = points * option.scoreMultiplier;
          interestPoints[majorOrTag] =
              (interestPoints[majorOrTag] ?? 0) + boostedPoints;
        });
      }

      // 2. Get all majors for the student's track and filter by profile preferences
      List<String> prefTypes = [];
      if (Get.isRegistered<ProfileController>()) {
        prefTypes = Get.find<ProfileController>().selectedProgramTypes;
      }

      final List<MajorModel> allTrackMajors = MajorsController.to.majorsList.where((major) {
        if (prefTypes.isEmpty) return true;
        final typeLower = major.universityType.toLowerCase();
        final isPublicRequested = prefTypes.contains("pt_public");
        final isPrivateRequested = prefTypes.contains("pt_private");
        
        if (typeLower.contains("public") && !isPublicRequested) return false;
        if (typeLower.contains("private") && !isPrivateRequested) return false;
        
        return true;
      }).toList();

      // 3. Score each major
      final List<MajorModel> matchedMajors = [];

      for (var major in allTrackMajors) {
        double compatibility = 50.0; // Base score

        // Interest Match: check if major id, track tags, or English/Arabic names have points
        double interestBonus = 0;
        final String nameEn = major.name.en.toLowerCase();
        final String nameAr = major.name.ar.toLowerCase();

        interestPoints.forEach((key, points) {
          if (major.id.toLowerCase().contains(key) || 
              major.trackTags.any((t) => t.toLowerCase().contains(key)) ||
              nameEn.contains(key) ||
              nameAr.contains(key)) {
            interestBonus += points;
          }
        });
        compatibility += interestBonus;

        // Grade Match: Comparison with AI Approximated Grade
        final diff = student.tawjihiPercentage - major.predictedTanafos;
        if (diff >= 2.0)
          compatibility += 15; // Very safe
        else if (diff >= 0)
          compatibility += 10; // Safe
        else if (diff >= -2.0)
          compatibility += 5; // Competitive/Possible
        else
          compatibility -= 10; // Hard/Ambitious

        // Normalize compatibility to 0-100
        major.compatibilityScore = compatibility.clamp(0.0, 100.0);
        matchedMajors.add(major);
      }

      // 4. Sort by compatibility descending
      matchedMajors.sort(
        (a, b) =>
            (b.compatibilityScore ?? 0).compareTo(a.compatibilityScore ?? 0),
      );

      suggestedMajors.assignAll(matchedMajors);
    } catch (e) {
      Get.snackbar("Error", "Failed to calculate matches: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  void viewAllMajors() => Get.toNamed(RouteNames.allMajors);

  void retakeSurvey() {
    final qController = QuestionnaireController.to;
    qController.answers.clear();
    qController.isLoading.value = false;
    Get.offAllNamed(RouteNames.qGlobal);
  }
}
