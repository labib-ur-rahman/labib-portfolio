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
      name: 'Flutter',
      level: 90,
      category: 'Mobile',
      icon: Iconsax.mobile,
    ),
    SkillModel(
      name: 'Dart',
      level: 90,
      category: 'Language',
      icon: Iconsax.code,
    ),
    SkillModel(
      name: 'Firebase',
      level: 85,
      category: 'Backend',
      icon: Iconsax.cloud,
    ),
    SkillModel(
      name: 'REST API',
      level: 88,
      category: 'Integration',
      icon: Iconsax.link_circle,
    ),
    SkillModel(
      name: 'Git',
      level: 85,
      category: 'Tools',
      icon: Iconsax.code_circle,
    ),
    SkillModel(
      name: 'GetX',
      level: 88,
      category: 'State Management',
      icon: Iconsax.setting_2,
    ),
    SkillModel(
      name: 'Provider',
      level: 82,
      category: 'State Management',
      icon: Iconsax.setting_3,
    ),
    SkillModel(
      name: 'Bloc',
      level: 80,
      category: 'State Management',
      icon: Iconsax.setting_4,
    ),
    SkillModel(
      name: 'SQLite',
      level: 75,
      category: 'Database',
      icon: Iconsax.data,
    ),
    SkillModel(
      name: 'Hive',
      level: 78,
      category: 'Database',
      icon: Iconsax.archive,
    ),
    SkillModel(
      name: 'UI/UX Design',
      level: 85,
      category: 'Design',
      icon: Iconsax.brush_1,
    ),
    SkillModel(
      name: 'Figma',
      level: 80,
      category: 'Design',
      icon: Iconsax.pen_tool,
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
