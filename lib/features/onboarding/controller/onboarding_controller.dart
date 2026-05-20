import 'package:get/get.dart';
import 'package:tawjihi_new/data/models/student_preferences_model.dart';
import 'package:tawjihi_new/features/auth/controller/auth_controller.dart';
import '../../../core/utils/shared_prefs_helper.dart';
import '../../../core/routes/route_names.dart';
import '../../profile/controller/profile_controller.dart';

class OnboardingController extends GetxController {
  static OnboardingController get to => Get.find();

  final selectedGovernorate = "".obs;
  final openToOtherGovernorate = true.obs;
  final selectedProgramTypes = <String>[].obs;
  final selectedAdmissionTypes = <String>[].obs;
  final showAllOptions = false.obs;
  final wantsTest = true.obs; // true = take test, false = go home

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferencesFromLocal();
  }

  void _loadPreferencesFromLocal() {
    isLoading.value = true;
    final userId = Get.find<AuthController>().currentStudent.value?.id;
    if (userId == null) {
      isLoading.value = false;
      return;
    }

    final localData = SharedPrefsHelper.getPreferences(userId);
    
    if (localData != null) {
      try {
        final prefs = StudentPreferencesModel.fromJson(localData);
        selectedGovernorate.value = prefs.governorate;
        openToOtherGovernorate.value = prefs.openToOtherGovernorate;
        selectedProgramTypes.assignAll(prefs.programTypes);
        selectedAdmissionTypes.assignAll(prefs.admissionTypes);
        showAllOptions.value = prefs.showAllOptions;
      } catch (_) {
        selectedGovernorate.value = "gov_amman";
      }
    } else {
      selectedGovernorate.value = "gov_amman";
    }
    isLoading.value = false;
  }

  void toggleProgramType(String typeKey) {
    if (selectedProgramTypes.contains(typeKey)) {
      selectedProgramTypes.remove(typeKey);
    } else {
      selectedProgramTypes.add(typeKey);
    }
  }

  void toggleAdmissionType(String typeKey) {
    if (selectedAdmissionTypes.contains(typeKey)) {
      selectedAdmissionTypes.remove(typeKey);
    } else {
      selectedAdmissionTypes.add(typeKey);
    }
  }

  Future<void> saveAndContinue() async {
    isLoading.value = true;

    final prefModel = StudentPreferencesModel(
      governorate: selectedGovernorate.value,
      openToOtherGovernorate: openToOtherGovernorate.value,
      programTypes: selectedProgramTypes.toList(),
      admissionTypes: selectedAdmissionTypes.toList(),
      showAllOptions: showAllOptions.value,
      questionnaireJson: "{}",
    );

    final userId = Get.find<AuthController>().currentStudent.value?.id;
    if (userId != null) {
      await SharedPrefsHelper.savePreferences(userId, prefModel.toJson());
    }

    // Sync ProfileController if alive
    try {
      if (Get.isRegistered<ProfileController>()) {
        final profile = Get.find<ProfileController>();
        profile.governorate.value = selectedGovernorate.value;
        profile.canTravel.value = openToOtherGovernorate.value;
        profile.selectedProgramTypes.assignAll(selectedProgramTypes);
        profile.selectedAdmissionTypes.assignAll(selectedAdmissionTypes);
      }
    } catch (_) {}

    isLoading.value = false;

    if (wantsTest.value) {
      Get.offAllNamed(RouteNames.qGlobal);
    } else {
      Get.offAllNamed(RouteNames.dashboard);
    }
  }
}
