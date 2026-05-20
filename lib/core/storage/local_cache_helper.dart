import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCacheHelper {
  static const String _detailsPrefix = "major_details_";
  static const String _graduatesPrefix = "major_graduates_";
  static const String _timestampPrefix = "timestamp_";

  static Future<void> saveDetails(String id, Map<String, dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("${_detailsPrefix}$id", jsonEncode(json));
    await prefs.setInt("${_timestampPrefix}${_detailsPrefix}$id", DateTime.now().millisecondsSinceEpoch);
  }

  static Future<Map<String, dynamic>?> getDetails(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("${_detailsPrefix}$id");
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<void> saveGraduates(String id, List<dynamic> json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("${_graduatesPrefix}$id", jsonEncode(json));
    await prefs.setInt("${_timestampPrefix}${_graduatesPrefix}$id", DateTime.now().millisecondsSinceEpoch);
  }

  static Future<List<dynamic>?> getGraduates(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("${_graduatesPrefix}$id");
    if (data != null) {
      return jsonDecode(data) as List<dynamic>;
    }
    return null;
  }

  static Future<bool> isCacheExpired(String key, {Duration ttl = const Duration(hours: 24)}) async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt("${_timestampPrefix}$key");
    if (timestamp == null) return true;
    
    final lastFetch = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateTime.now().difference(lastFetch) > ttl;
  }

  static String getDetailsKey(String id) => "${_detailsPrefix}$id";
  static String getGraduatesKey(String id) => "${_graduatesPrefix}$id";
}
