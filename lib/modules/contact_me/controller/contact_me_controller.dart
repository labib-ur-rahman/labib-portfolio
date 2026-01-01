import 'package:get/get.dart';

class ContactMeController extends GetxController {
  final nameController = ''.obs;
  final emailController = ''.obs;
  final messageController = ''.obs;
  final isSubmitting = false.obs;
  final animationKey = 0.obs;

  @override
  void onInit() {
    super.onInit();
    animationKey.value = DateTime.now().millisecondsSinceEpoch;
  }

  void setName(String value) => nameController.value = value;
  void setEmail(String value) => emailController.value = value;
  void setMessage(String value) => messageController.value = value;

  Future<void> submitForm() async {
    if (nameController.value.isEmpty ||
        emailController.value.isEmpty ||
        messageController.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSubmitting.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    Get.snackbar(
      'Success',
      'Message sent successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );

    // Reset form
    nameController.value = '';
    emailController.value = '';
    messageController.value = '';
    isSubmitting.value = false;
  }
}
