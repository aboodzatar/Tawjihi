import 'package:get/get.dart';
import '../../../data/services/local_data_service.dart';
import '../../../data/models/major_model.dart';
import '../../majors/controller/majors_controller.dart';

class MajorDetailsController extends GetxController {
  final _localData = Get.find<LocalDataService>();

  String? majorId;
  final major = Rxn<MajorModel>();
  final graduates = <GraduateContact>[].obs;

  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    // Support both arguments (Legacy) and parameters (Deep Link)
    majorId = Get.parameters['id'] ?? (Get.arguments as String?);

    if (majorId == null) {
      hasError.value = true;
      errorMessage.value = "Major ID is missing";
      isLoading.value = false;
    } else {
      loadMajorDetails();
    }
  }

  void loadMajorDetails() {
    if (majorId == null) return;

    isLoading.value = true;
    hasError.value = false;

    // Look up in local data
    final majorData = _localData.findMajorByCombinedId(majorId!);
    
    if (majorData != null) {
      // Find university
      final uni = _localData.getAllUniversities().firstWhere((u) => u.majors.contains(majorData));
      
      // Use the mapping logic from MajorsController for consistency
      major.value = MajorsController.to.mapLocalDataToUI(uni, majorData);
      graduates.assignAll(major.value!.graduateContacts);
      
      isLoading.value = false;
    } else {
      hasError.value = true;
      errorMessage.value = "Major details not found in local dataset.";
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
