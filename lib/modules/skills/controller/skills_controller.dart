import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SkillsController extends GetxController {
  final RxInt hoveredSkillIndex = (-1).obs;
  final RxBool showContent = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Animate content after a delay
    Future.delayed(const Duration(milliseconds: 300), () {
      showContent.value = true;
    });
  }

  void setHoveredSkill(int index) {
    hoveredSkillIndex.value = index;
  }

  void clearHoveredSkill() {
    hoveredSkillIndex.value = -1;
  }

  // Skills data based on resume with icons
  final List<SkillModel> skills = [
    SkillModel(
      name: 'Flutter & Dart',
      level: 92,
      category: 'Mobile Development',
      icon: Iconsax.mobile,
    ),
    SkillModel(
      name: 'Cross-platform Development',
      level: 88,
      category: 'Mobile Development',
      icon: Iconsax.global,
    ),
    SkillModel(
      name: 'Native Android (Kotlin, Java, XML)',
      level: 82,
      category: 'Mobile Development',
      icon: Iconsax.mobile,
    ),
    SkillModel(
      name: 'State Management (GetX)',
      level: 86,
      category: 'Mobile Development',
      icon: Iconsax.setting_2,
    ),
    SkillModel(
      name: 'RESTful APIs',
      level: 88,
      category: 'Backend & APIs',
      icon: Iconsax.link_circle,
    ),
    SkillModel(
      name: 'Firebase & Google Cloud',
      level: 85,
      category: 'Backend & APIs',
      icon: Iconsax.cloud,
    ),
    SkillModel(
      name: 'JWT Authentication',
      level: 80,
      category: 'Backend & APIs',
      icon: Iconsax.info_circle,
    ),
    SkillModel(
      name: 'Cloud Messaging (FCM)',
      level: 82,
      category: 'Backend & APIs',
      icon: Iconsax.send_2,
    ),
    SkillModel(
      name: 'Firestore',
      level: 84,
      category: 'Storage & Database',
      icon: Iconsax.data,
    ),
    SkillModel(
      name: 'Shared Preferences',
      level: 78,
      category: 'Storage & Database',
      icon: Iconsax.document_text,
    ),
    SkillModel(
      name: 'Hive Database',
      level: 80,
      category: 'Storage & Database',
      icon: Iconsax.archive,
    ),
    SkillModel(
      name: 'Secure Storage',
      level: 76,
      category: 'Storage & Database',
      icon: Iconsax.user_octagon,
    ),
    SkillModel(
      name: 'Git & GitHub',
      level: 86,
      category: 'Tools & Services',
      icon: Iconsax.code_circle,
    ),
    SkillModel(
      name: 'Google Maps SDK',
      level: 80,
      category: 'Tools & Services',
      icon: Iconsax.location,
    ),
    SkillModel(
      name: 'Stripe Payments',
      level: 75,
      category: 'Tools & Services',
      icon: Iconsax.briefcase,
    ),
    SkillModel(
      name: 'Play Store & App Store Deployment',
      level: 83,
      category: 'Tools & Services',
      icon: Iconsax.arrow_right_1,
    ),
  ];

  final List<StatModel> stats = [
    StatModel(count: '5+', label: 'Years Experience'),
    StatModel(count: '50+', label: 'Projects Completed'),
  ];
}

class SkillModel {
  final String name;
  final int level;
  final String category;
  final IconData icon;

  SkillModel({
    required this.name,
    required this.level,
    required this.category,
    required this.icon,
  });
}

class StatModel {
  final String count;
  final String label;

  StatModel({required this.count, required this.label});
}
