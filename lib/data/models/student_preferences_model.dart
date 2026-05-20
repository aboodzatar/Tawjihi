class StudentPreferencesModel {
  final String governorate;
  final bool openToOtherGovernorate;
  final List<String> programTypes; // ["pt_public", "pt_private"]
  final List<String> admissionTypes; // ["at_competitive", "at_parallel"]
  final bool showAllOptions;
  final String questionnaireJson;

  StudentPreferencesModel({
    required this.governorate,
    required this.openToOtherGovernorate,
    required this.programTypes,
    required this.admissionTypes,
    required this.showAllOptions,
    this.questionnaireJson = "{}",
  });

  Map<String, dynamic> toJson() => {
    'governorate': governorate,
    'openToOtherGovernorate': openToOtherGovernorate,
    'programTypes': programTypes,
    'admissionTypes': admissionTypes,
    'showAllOptions': showAllOptions,
    'questionnaireJson': questionnaireJson,
  };

  factory StudentPreferencesModel.fromJson(Map<String, dynamic> json) => StudentPreferencesModel(
    governorate: json['preferredGovernorates'] != null && (json['preferredGovernorates'] as List).isNotEmpty 
      ? json['preferredGovernorates'][0] 
      : (json['governorate'] ?? "gov_amman"),
    openToOtherGovernorate: json['willingToRelocate'] ?? json['openToOtherGovernorate'] ?? true,
    programTypes: List<String>.from(json['programTypes'] ?? []),
    admissionTypes: List<String>.from(json['admissionChannels'] ?? json['admissionTypes'] ?? []),
    showAllOptions: json['showAllOptions'] ?? true,
    questionnaireJson: json['questionnaireJson'] ?? "{}",
  );
}
