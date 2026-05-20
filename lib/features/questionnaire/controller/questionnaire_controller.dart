import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/shared_prefs_helper.dart';
import '../../../core/routes/route_names.dart';
import '../../auth/controller/auth_controller.dart';
import '../../../data/mock/mock_questions_data.dart';

class QuestionnaireController extends GetxController {
  static QuestionnaireController get to => Get.find<QuestionnaireController>();

  // Consistently store all answers in one map
  final answers = <String, String>{}.obs;
  
  // New Question Model
  final questions = <QuestionnaireQuestion>[].obs;
  final isLoading = false.obs;
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initController();
  }

  Future<void> _initController() async {
    _loadFromLocal();
    await loadQuestions();
  }

  Future<void> loadQuestions() async {
    isLoading.value = true;
    final String track = AuthController.to.currentStudent.value?.track ?? "track_it";
    final q = MockQuestionsData.getQuestionsByTrack(track);
    questions.assignAll(q);
    isLoading.value = false;
  }

  /// Load from local storage
  void _loadFromLocal() {
    final userId = AuthController.to.currentStudent.value?.id;
    if (userId != null) {
      answers.assignAll(SharedPrefsHelper.getQGlobalAnswers(userId) ?? {});
    }
  }

  /// Save current state to local storage
  void _syncToLocal() {
    final userId = AuthController.to.currentStudent.value?.id;
    if (userId != null) {
      SharedPrefsHelper.saveQGlobalAnswers(userId, Map<String, String>.from(answers));
    }
  }

  double get progress => questions.isEmpty ? 0 : answers.length / questions.length;

  void updateAnswer(String qId, String ans) {
    answers[qId] = ans;
    _syncToLocal();
  }

  Future<void> submit() async {
    if (answers.length < questions.length) {
      final l10n = AppLocalizations.of(Get.context!)!;
      Get.snackbar(
        l10n.success.split(" ").first, // Or some generic title key
        l10n.msg_answer_all_questions,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.withOpacity(0.9),
        colorText: Colors.white,
      );
      return;
    }
    
    isSubmitting.value = true;
    _syncToLocal();
    
    // Simulate processing
    await Future.delayed(const Duration(milliseconds: 500));
    isSubmitting.value = false;
    
    Get.toNamed(RouteNames.qSuggestedMajors);
  }
}
