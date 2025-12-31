import 'package:get/get.dart';

class ExperienceController extends GetxController {
  final List<ExperienceModel> experiences = [
    ExperienceModel(
      company: 'Softvence Agency, Dhaka',
      duration: 'Dec 2024 - Present',
      role: 'Jr. Flutter Developer',
      description:
          'Building cross-platform mobile applications with Flutter. Working on various client projects with clean architecture and state management.',
      isActive: true,
    ),
    ExperienceModel(
      company: 'Uttara University',
      duration: '2021 - Present',
      role: 'BSc in CSE',
      description:
          'Studying Computer Science and Engineering. Learning advanced programming concepts, data structures, and software engineering principles.',
      isActive: false,
    ),
    ExperienceModel(
      company: 'Self Learning',
      duration: '2022 - Present',
      role: 'Flutter & Kotlin Developer',
      description:
          'Self-taught mobile development. Proficient in Flutter for cross-platform and Kotlin for native Android development.',
      isActive: true,
    ),
  ];
}

class ExperienceModel {
  final String company;
  final String duration;
  final String role;
  final String description;
  final bool isActive;

  ExperienceModel({
    required this.company,
    required this.duration,
    required this.role,
    required this.description,
    this.isActive = false,
  });
}
