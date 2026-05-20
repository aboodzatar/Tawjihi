import 'package:flutter/material.dart';

class AppConstants {
  static const double padding = 16.0;
  static const double borderRadius = 12.0;

  // Persistence Keys
  static const String themeKey = 'isDarkMode';
  static const String localeKey = 'localeCode';
  static const String preferencesKey = 'studentPreferences';
  static const String keyStudentTab = 'studentTrack';
  static const String keyGovernorate = 'governorate';
  static const String keyCanTravel = 'canTravel';
  static const String keyProgramTypes = 'programTypes';
  static const String keyAdmissionChannels = 'admissionChannels';
  static const String keyQuestionnaireAnswers = 'questionnaireAnswers';
  static const String keyQGlobalAnswers = 'q_global_answers';
  static const String keyQSelectedTrack = 'q_selected_track';
  static const String keyQTrackAnswers = 'q_track_answers';

  // Internal Keys (Mapped to ARB)
  static const List<String> governorateKeys = [
    "gov_amman",
    "gov_irbid",
    "gov_zarqa",
    "gov_balqa",
    "gov_madaba",
    "gov_mafraq",
    "gov_jerash",
    "gov_ajloun",
    "gov_karak",
    "gov_tafila",
    "gov_maan",
    "gov_aqaba",
  ];

  static const List<String> programTypeKeys = ["pt_public", "pt_private"];

  static const List<String> admissionTypeKeys = [
    "at_competitive",
    "at_parallel",
  ];

  // Aliases for compatibility
  static const List<String> governorates = governorateKeys;
  static const List<String> programTypes = programTypeKeys;
  static const List<String> admissionTypes = admissionTypeKeys;

  // AI Configuration
  static const String geminiApiKey = 'AIzaSyAbNGQYSpnLQEyazSwI6CGm7iAgORoE8do';
  static const String geminiModel = 'gemini-2.5-flash';
}

class AppColors {
  static const Color primaryLight = Color(0xFF00A896);
  static const Color primaryDark = Color(0xFF02C39A);
  static const Color secondary = Color(0xFF028090);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E1E1E);
}
