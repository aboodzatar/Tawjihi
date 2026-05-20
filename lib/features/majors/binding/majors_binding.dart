import 'package:get/get.dart';
import '../controller/majors_controller.dart';

class MajorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MajorsController>(() => MajorsController());
  }
}
