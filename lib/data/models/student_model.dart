class StudentModel {
  final String id;
  final String fullName;
  final double tawjihiPercentage;
  final String track; // e.g., "Scientific", "Literary"
  final String governorate; // Internal Key (e.g. "gov_amman")

  StudentModel({
    required this.id,
    required this.fullName,
    required this.tawjihiPercentage,
    required this.track,
    required this.governorate,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'tawjihiPercentage': tawjihiPercentage,
    'track': track,
    'governorate': governorate,
  };

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    id: json['id'],
    fullName: json['fullName'],
    tawjihiPercentage: json['tawjihiPercentage'].toDouble(),
    track: json['track'],
    governorate: json['governorate'],
  );
}
