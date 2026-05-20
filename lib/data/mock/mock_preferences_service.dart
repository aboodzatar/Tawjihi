import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/constants.dart';
import '../models/student_preferences_model.dart';

class MockPreferencesService {
  static Future<void> savePreferences(StudentPreferencesModel prefs) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(AppConstants.preferencesKey, jsonEncode(prefs.toJson()));
  }

  static Future<StudentPreferencesModel?> getPreferences() async {
    final sp = await SharedPreferences.getInstance();
    final data = sp.getString(AppConstants.preferencesKey);
    if (data != null) {
      return StudentPreferencesModel.fromJson(jsonDecode(data));
    }
    return null;
  }
}
