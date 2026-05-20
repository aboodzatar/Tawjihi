import 'package:get/get.dart';
import '../controller/suggested_majors_controller.dart';
import '../controller/questionnaire_controller.dart';
import '../../majors/controller/majors_controller.dart';

class QuestionnaireBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MajorsController());
    Get.lazyPut(() => QuestionnaireController());
    Get.lazyPut(() => SuggestedMajorsController());
  }
}
