import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tawjihi_new/core/routes/route_names.dart';
import 'package:tawjihi_new/core/storage/secure_storage_helper.dart';
import 'package:tawjihi_new/core/utils/shared_prefs_helper.dart';

import '../../../data/services/local_data_service.dart';
import '../../../data/models/student_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  // Reference to our new offline data service 
  final _localData = Get.find<LocalDataService>();

  final isDarkMode = SharedPrefsHelper.isDarkMode.obs;
  final currentLocale = SharedPrefsHelper.localeCode.obs;
  
  final currentStudent = Rxn<StudentModel>();
  final studentMasar = "Scientific".obs; // Default track
  
  final isLoading = false.obs;
  final isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    _checkExistingSession();
  }

  Future<void> _checkExistingSession() async {
    final studentId = await SecureStorageHelper.getStudentId();
    
    if (studentId != null) {
      // Look up student in local mock data
      final mockStudent = _localData.findStudentById(studentId);
      if (mockStudent != null) {
        _mapMockToCurrentStudent(mockStudent);
        isLoggedIn.value = true;
      }
    }
  }

  void _mapMockToCurrentStudent(StudentMockData mock) {
    currentStudent.value = StudentModel(
      id: mock.id,
      fullName: currentLocale.value == 'ar' ? mock.nameAr : mock.nameEn,
      tawjihiPercentage: mock.grade,
      track: mock.trackId,
      governorate: "Amman", // Default for mock
    );
    studentMasar.value = mock.trackId;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    SharedPrefsHelper.setDarkMode(isDarkMode.value);
  }

  void toggleLanguage() {
    String newLocale = currentLocale.value == 'ar' ? 'en' : 'ar';
    currentLocale.value = newLocale;
    Get.updateLocale(Locale(newLocale));
    SharedPrefsHelper.setLocaleCode(newLocale);
    
    // Refresh name if student is logged in
    if (currentStudent.value != null) {
      final mock = _localData.findStudentById(currentStudent.value!.id);
      if (mock != null) _mapMockToCurrentStudent(mock);
    }
  }

  Future<void> login(String nationalId) async {
    final l10n = AppLocalizations.of(Get.context!)!;

    if (nationalId.isEmpty) {
      Get.snackbar(
        l10n.error_title, 
        l10n.invalid_input,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    
    // Simulate slight delay for premium feel
    await Future.delayed(const Duration(milliseconds: 600));
    
    final mockStudent = _localData.findStudentById(nationalId);
    isLoading.value = false;

    if (mockStudent != null) {
      _mapMockToCurrentStudent(mockStudent);
      
      // Save session locally
      await SecureStorageHelper.saveToken("local-session-token");
      await SecureStorageHelper.saveStudentId(mockStudent.id);
      
      isLoggedIn.value = true;
      
      if (SharedPrefsHelper.getPreferences(mockStudent.id) == null) {
        Get.offAllNamed(RouteNames.preferences);
      } else {
        Get.offAllNamed(RouteNames.dashboard);
      }
    } else {
      Get.snackbar(
        l10n.error_title, 
        l10n.student_not_found,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void logout() async {
    isLoading.value = true;
    await SecureStorageHelper.clearAuthData();
    isLoggedIn.value = false;
    currentStudent.value = null;
    isLoading.value = false;
    Get.offAllNamed(RouteNames.login);
  }
}
