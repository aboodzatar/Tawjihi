import 'package:get/get.dart';
import 'package:tawjihi_new/data/models/student_preferences_model.dart';
import 'package:tawjihi_new/features/majors/controller/majors_controller.dart';
import '../../../core/utils/shared_prefs_helper.dart';
import '../../auth/controller/auth_controller.dart';
import '../../questionnaire/controller/suggested_majors_controller.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  // Observable student data
  final fullName = "".obs;
  final studentId = "".obs;
  final percentage = 0.0.obs;
  final track = "".obs;
  final governorate = "gov_amman".obs; 
  final canTravel = false.obs; // Default: not selected
  final selectedProgramTypes = <String>[].obs;
  final selectedAdmissionTypes = <String>[].obs;

  // Aliases for compatibility with legacy screens
  RxList<String> get programTypes => selectedProgramTypes;
  RxList<String> get admissionChannels => selectedAdmissionTypes;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initProfile();
  }

  void _initProfile() {
    isLoading.value = true;
    
    // Refresh student info from AuthController
    final auth = AuthController.to;
    final student = auth.currentStudent.value;
    
    if (student != null) {
      fullName.value = student.fullName;
      studentId.value = student.id;
      percentage.value = student.tawjihiPercentage;
      track.value = student.track;
    }

    _loadFromLocal();
    isLoading.value = false;
  }

  /// Apply preferences from model
  void _applyPreferences(StudentPreferencesModel prefs) {
    governorate.value = prefs.governorate.isEmpty ? "gov_amman" : prefs.governorate;
    canTravel.value = prefs.openToOtherGovernorate;
    selectedProgramTypes.assignAll(prefs.programTypes);
    selectedAdmissionTypes.assignAll(prefs.admissionTypes);
  }

  /// Apply clean defaults (nothing selected)
  void _applyDefaults() {
    governorate.value = "gov_amman";
    canTravel.value = false;
    selectedProgramTypes.clear();
    selectedAdmissionTypes.clear();
  }

  /// Save preferences to local storage
  void _saveToLocal(StudentPreferencesModel prefs) {
    final userId = AuthController.to.currentStudent.value?.id;
    if (userId != null) {
      SharedPrefsHelper.savePreferences(userId, prefs.toJson());
    }
  }

  /// Load preferences from local storage
  void _loadFromLocal() {
    final userId = AuthController.to.currentStudent.value?.id;
    final localData = userId != null ? SharedPrefsHelper.getPreferences(userId) : null;
    if (localData != null) {
      try {
        final prefs = StudentPreferencesModel.fromJson(localData);
        _applyPreferences(prefs);
      } catch (_) {
        _applyDefaults();
      }
    } else {
      _applyDefaults();
    }
  }

  void toggleProgramType(String typeKey) {
    if (selectedProgramTypes.contains(typeKey)) {
      selectedProgramTypes.remove(typeKey);
    } else {
      selectedProgramTypes.add(typeKey);
    }
    saveProfile();
  }

  void toggleAdmissionType(String typeKey) {
    if (selectedAdmissionTypes.contains(typeKey)) {
      selectedAdmissionTypes.remove(typeKey);
    } else {
      selectedAdmissionTypes.add(typeKey);
    }
    saveProfile();
  }

  Future<void> saveProfile() async {
    final prefModel = StudentPreferencesModel(
      governorate: governorate.value,
      openToOtherGovernorate: canTravel.value,
      programTypes: selectedProgramTypes.toList(),
      admissionTypes: selectedAdmissionTypes.toList(),
      showAllOptions: true, 
    );

    _saveToLocal(prefModel);

    if (Get.isRegistered<MajorsController>()) {
      Get.find<MajorsController>().loadMajors();
    }
    
    // Also notify SuggestedMajorsController to update its list based on new majors
    try {
      if (Get.isRegistered<SuggestedMajorsController>()) {
        Get.find<SuggestedMajorsController>().runMatching();
      }
    } catch (_) {}
  }

  Future<void> updateProfile({
    String? newTrack,
    String? newGov,
    bool? newTravel,
    List<String>? newPrograms,
    List<String>? newChannels,
  }) async {
    if (newTrack != null) track.value = newTrack;
    if (newGov != null) governorate.value = newGov;
    if (newTravel != null) canTravel.value = newTravel;
    if (newPrograms != null) selectedProgramTypes.assignAll(newPrograms);
    if (newChannels != null) selectedAdmissionTypes.assignAll(newChannels);
    
    return saveProfile();
  }
}
