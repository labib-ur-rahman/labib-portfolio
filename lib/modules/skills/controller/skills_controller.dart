import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
      icon: FontAwesomeIcons.mobileScreen,
    ),
    SkillModel(
      name: 'Cross-platform Development',
      level: 88,
      category: 'Mobile Development',
      icon: FontAwesomeIcons.globe,
    ),
    SkillModel(
      name: 'Native Android (Kotlin, Java, XML)',
      level: 82,
      category: 'Mobile Development',
      icon: FontAwesomeIcons.mobileScreen,
    ),
    SkillModel(
      name: 'State Management (GetX)',
      level: 86,
      category: 'Mobile Development',
      icon: FontAwesomeIcons.gear,
    ),
    SkillModel(
      name: 'RESTful APIs',
      level: 88,
      category: 'Backend & APIs',
      icon: FontAwesomeIcons.link,
    ),
    SkillModel(
      name: 'Firebase & Google Cloud',
      level: 85,
      category: 'Backend & APIs',
      icon: FontAwesomeIcons.cloud,
    ),
    SkillModel(
      name: 'JWT Authentication',
      level: 80,
      category: 'Backend & APIs',
      icon: FontAwesomeIcons.circleInfo,
    ),
    SkillModel(
      name: 'Cloud Messaging (FCM)',
      level: 82,
      category: 'Backend & APIs',
      icon: FontAwesomeIcons.solidPaperPlane,
    ),
    SkillModel(
      name: 'Firestore',
      level: 84,
      category: 'Storage & Database',
      icon: FontAwesomeIcons.database,
    ),
    SkillModel(
      name: 'Shared Preferences',
      level: 78,
      category: 'Storage & Database',
      icon: FontAwesomeIcons.fileLines,
    ),
    SkillModel(
      name: 'Hive Database',
      level: 80,
      category: 'Storage & Database',
      icon: FontAwesomeIcons.boxArchive,
    ),
    SkillModel(
      name: 'Secure Storage',
      level: 76,
      category: 'Storage & Database',
      icon: FontAwesomeIcons.shieldHalved,
    ),
    SkillModel(
      name: 'Git & GitHub',
      level: 86,
      category: 'Tools & Services',
      icon: FontAwesomeIcons.code,
    ),
    SkillModel(
      name: 'Google Maps SDK',
      level: 80,
      category: 'Tools & Services',
      icon: FontAwesomeIcons.locationDot,
    ),
    SkillModel(
      name: 'Stripe Payments',
      level: 75,
      category: 'Tools & Services',
      icon: FontAwesomeIcons.briefcase,
    ),
    SkillModel(
      name: 'Play Store & App Store Deployment',
      level: 83,
      category: 'Tools & Services',
      icon: FontAwesomeIcons.arrowRight,
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
  final FaIconData icon;

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
