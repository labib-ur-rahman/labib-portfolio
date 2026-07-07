import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../../core/constants/app_colors.dart';

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
      _showSnack(
        title: 'Missing details',
        message: 'Please fill out all fields before sending.',
        isError: true,
      );
      return;
    }

    if (name.length < 2) {
      _showSnack(
        title: 'Invalid name',
        message: 'Name must be at least 2 characters.',
        isError: true,
      );
      return;
    }

    if (!_isValidEmail(email)) {
      _showSnack(
        title: 'Invalid email',
        message: 'Please enter a valid email address.',
        isError: true,
      );
      return;
    }

    if (message.length < 10) {
      _showSnack(
        title: 'Message too short',
        message: 'Please add a bit more detail in your message.',
        isError: true,
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
      _showSnack(
        title: 'Send failed',
        message: 'Could not send message. Please try again.',
        isError: true,
      );
      return;
    }

    _showSnack(
      title: 'Sent successfully',
      message: 'Thanks! Your message is on its way.',
      isError: false,
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

  bool _isValidEmail(String value) {
    final emailRegex = RegExp(
      r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$',
    );
    return emailRegex.hasMatch(value);
  }

  void _showSnack({
    required String title,
    required String message,
    required bool isError,
  }) {
    final accentColor = isError
        ? const Color(0xFFE5484D)
        : const Color(0xFF22C55E);
    final backgroundBase = isError
        ? const Color(0xFF2B0F14)
        : const Color(0xFF0B1F14);

    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
        messageText: Text(
          message,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.5,
            height: 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: backgroundBase,
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        maxWidth: 420,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        borderRadius: 20,
        icon: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: accentColor.withValues(alpha: 0.15),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
          child: Center(
            child: FaIcon(
              isError
                  ? FontAwesomeIcons.solidCircleXmark
                  : FontAwesomeIcons.solidCircleCheck,
              color: accentColor,
              size: 26,
            ),
          ),
        ),
        borderColor: accentColor.withValues(alpha: 0.4),
        borderWidth: 1.5,
        boxShadows: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.35),
            blurRadius: 32,
            offset: const Offset(0, 16),
            spreadRadius: 4,
          ),
          BoxShadow(
            color: accentColor.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
        backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundBase.withValues(alpha: 0.95),
            AppColors.backgroundDark.withValues(alpha: 0.95),
          ],
        ),
        duration: const Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
      ),
    );
  }
}
