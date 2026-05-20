import 'student_model.dart';

class AuthResponseModel {
  final StudentModel student;
  final String token;

  AuthResponseModel({
    required this.student,
    required this.token,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      student: StudentModel(
        id: json['studentId']?.toString() ?? "", 
        fullName: json['fullNameAr'] ?? "",
        tawjihiPercentage: (json['tawjihiScore'] as num?)?.toDouble() ?? 0.0,
        track: json['masar'] ?? "",
        governorate: json['governorate'] ?? "",
      ),
      token: json['token'] ?? "",
    );
  }
}
