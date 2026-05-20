import 'package:get/get.dart';

class BilingualText {
  final String ar;
  final String en;

  const BilingualText({required this.ar, required this.en});

  String get localized => Get.locale?.languageCode == 'ar' ? ar : en;
}
