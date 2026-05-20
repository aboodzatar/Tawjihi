import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'constants.dart';

class SharedPrefsHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    Get.put(_prefs);
  }

  static SharedPreferences get instance => _prefs;

  // Theme & Locale
  static bool get isDarkMode => _prefs.getBool(AppConstants.themeKey) ?? false;
  static Future<void> setDarkMode(bool value) => _prefs.setBool(AppConstants.themeKey, value);

  static String get localeCode => _prefs.getString(AppConstants.localeKey) ?? 'ar';
  static Future<void> setLocaleCode(String value) => _prefs.setString(AppConstants.localeKey, value);

  // Onboarding Preferences
  static Future<void> savePreferences(String userId, Map<String, dynamic> data) async {
    await _prefs.setString("${AppConstants.preferencesKey}_$userId", jsonEncode(data));
  }

  static Map<String, dynamic>? getPreferences(String userId) {
    final str = _prefs.getString("${AppConstants.preferencesKey}_$userId");
    if (str == null) return null;
    return jsonDecode(str) as Map<String, dynamic>;
  }

  // Questionnaire Answers
  static Future<void> saveQuestionnaireAnswers(String userId, Map<String, String> answers) async {
    await _prefs.setString("${AppConstants.keyQuestionnaireAnswers}_$userId", jsonEncode(answers));
  }

  static Map<String, String>? getQuestionnaireAnswers(String userId) {
    final str = _prefs.getString("${AppConstants.keyQuestionnaireAnswers}_$userId");
    if (str == null) return null;
    final Map<String, dynamic> decoded = jsonDecode(str);
    return decoded.map((key, value) => MapEntry(key, value.toString()));
  }

  // Multi-step Questionnaire Persistence
  static Future<void> saveQGlobalAnswers(String userId, Map<String, String> answers) async {
    await _prefs.setString("${AppConstants.keyQGlobalAnswers}_$userId", jsonEncode(answers));
  }

  static Map<String, String>? getQGlobalAnswers(String userId) {
    final str = _prefs.getString("${AppConstants.keyQGlobalAnswers}_$userId");
    if (str == null) return null;
    final Map<String, dynamic> decoded = jsonDecode(str);
    return decoded.map((key, value) => MapEntry(key, value.toString()));
  }

  static Future<void> saveQSelectedTrack(String userId, String trackId) async {
    await _prefs.setString("${AppConstants.keyQSelectedTrack}_$userId", trackId);
  }

  static String? getQSelectedTrack(String userId) {
    return _prefs.getString("${AppConstants.keyQSelectedTrack}_$userId");
  }

  static Future<void> saveQTrackAnswers(String userId, Map<String, String> answers) async {
    await _prefs.setString("${AppConstants.keyQTrackAnswers}_$userId", jsonEncode(answers));
  }

  static Map<String, String>? getQTrackAnswers(String userId) {
    final str = _prefs.getString("${AppConstants.keyQTrackAnswers}_$userId");
    if (str == null) return null;
    final Map<String, dynamic> decoded = jsonDecode(str);
    return decoded.map((key, value) => MapEntry(key, value.toString()));
  }

  // Clear Session
  static Future<void> clearAuth() async {
    await _prefs.remove('isLoggedIn');
    await _prefs.remove('studentData');
  }
}
