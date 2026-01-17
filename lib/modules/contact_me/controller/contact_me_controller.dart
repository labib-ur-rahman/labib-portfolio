import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ContactMeController extends GetxController {
  static const _serviceId = 'service_2immieh';
  static const _templateId = 'template_e7pn7ml';
  static const _publicKey = 'tFDE6O0N3VvXum-Mr';

  final nameController = ''.obs;
  final emailController = ''.obs;
  final subjectController = ''.obs;
  final messageController = ''.obs;
  final isSubmitting = false.obs;
  final animationKey = 0.obs;

  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final subjectTextController = TextEditingController();
  final messageTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    animationKey.value = DateTime.now().millisecondsSinceEpoch;
  }

  void setName(String value) => nameController.value = value;
  void setEmail(String value) => emailController.value = value;
  void setSubject(String value) => subjectController.value = value;
  void setMessage(String value) => messageController.value = value;

  @override
  void onClose() {
    nameTextController.dispose();
    emailTextController.dispose();
    subjectTextController.dispose();
    messageTextController.dispose();
    super.onClose();
  }

  Future<void> submitForm() async {
    final name = nameTextController.text.trim();
    final email = emailTextController.text.trim();
    final subject = subjectTextController.text.trim();
    final message = messageTextController.text.trim();

    if (name.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSubmitting.value = true;

    try {
      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: const {'Content-Type': 'application/json'},
        body: jsonEncode({
          'service_id': _serviceId,
          'template_id': _templateId,
          'user_id': _publicKey,
          'template_params': {
            'name': name,
            'email': email,
            'from_name': name,
            'from_email': email,
            'reply_to': email,
            'subject': subject,
            'message': message,
          },
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Email request failed: ${response.statusCode}');
      }
    } catch (_) {
      isSubmitting.value = false;
      Get.snackbar(
        'Error',
        'Could not send message. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.snackbar(
      'Success',
      'Message sent successfully!',
      snackPosition: SnackPosition.BOTTOM,
    );

    // Reset form
    nameTextController.clear();
    emailTextController.clear();
    subjectTextController.clear();
    messageTextController.clear();
    nameController.value = '';
    emailController.value = '';
    subjectController.value = '';
    messageController.value = '';
    isSubmitting.value = false;
  }
}
