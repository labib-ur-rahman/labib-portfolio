import 'dart:async';
import 'package:DeveloperLabib/core/constants/app_assets.dart';
import 'package:get/get.dart';

class ProjectModel {
  final String title;
  final String description;
  final List<String> technologies;
  final String image;
  final List<String> screenshots;
  final String? link;
  final String? linkLabel;
  final bool isPublished;

  ProjectModel({
    required this.title,
    required this.description,
    required this.technologies,
    required this.image,
    required this.screenshots,
    this.link,
    this.linkLabel,
    this.isPublished = false,
  });
}

class ProjectsController extends GetxController {
  final currentPage = 0.obs;
  final selectedProjectIndex = 0.obs;
  final RxBool showContent = false.obs;
  Timer? _autoScrollTimer;
  int maxPages = 9; // Default to mobile (1 item per page)

  @override
  void onInit() {
    super.onInit();
    // Trigger animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      showContent.value = true;
    });

    // Start auto-scroll
    startAutoScroll();
  }

  @override
  void onClose() {
    _autoScrollTimer?.cancel();
    super.onClose();
  }

  void startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage.value < maxPages - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
    });
  }

  void setMaxPages(int pages) {
    maxPages = pages;
    // Reset if current page is beyond new max
    if (currentPage.value >= maxPages) {
      currentPage.value = 0;
    }
  }

  void stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  void resumeAutoScroll() {
    startAutoScroll();
  }

  final List<ProjectModel> projects = [
    /// -- Deep Quran App --
    ProjectModel(
      title: '*Deep Quran*: Digital Quran Recitation & Study Platform',
      description:
          'Islamic learning platform featuring audio recitation, translations, and optimized reading experience with focus on performance and accessibility.',
      technologies: ['Flutter', 'Firebase', 'Dart', 'SQLite', 'RestAPI'],
      image: AppAssets.deepQuranSS01,
      screenshots: [
        AppAssets.deepQuranSS01,
        AppAssets.deepQuranSS02,
        AppAssets.deepQuranSS03,
        AppAssets.deepQuranSS04,
        AppAssets.deepQuranSS05,
        AppAssets.deepQuranSS06,
        AppAssets.deepQuranSS07,
      ],
      link: 'https://play.google.com/store/apps/details?id=com.deepquran.app',
      linkLabel: 'Play Store',
      isPublished: true,
    ),

    /// -- Go Get a Genie --
    ProjectModel(
      title: '*Go Get a Genie*: AI-Powered Project & Task Management App',
      description:
          'An AI-powered project and task management application built with Flutter. Boost your productivity with intelligent task planning, AI-assisted project creation, and smart chatbot assistance.',
      technologies: ['Flutter', 'Firebase', 'Dart', 'RestAPI'],
      image: AppAssets.gggSS01,
      screenshots: [
        AppAssets.gggSS01,
        AppAssets.gggSS02,
        AppAssets.gggSS03,
        AppAssets.gggSS04,
        AppAssets.gggSS05,
        AppAssets.gggSS06,
        AppAssets.gggSS07,
      ],
      link: 'https://play.google.com/store/apps/details?id=com.gogetagenie.app',
      linkLabel: 'Play Store',
      isPublished: true,
    ),

    /// -- SHIRAH --
    ProjectModel(
      title:
          '*SHIRAH*: Business & Community Super App for Learning, Earning & Networking',
      description:
          'SHIRAH is a Business & Community Super App for Bangladesh where users can: Learn business skills, Use digital services (recharge, telecom offers), Sell products without inventory, Complete small tasks (micro jobs), Earn money through real work, Build a trusted verified network',
      technologies: ['Flutter', 'Firebase', 'Dart', 'Google Cloud', 'RestAPI'],
      image: AppAssets.shirahSS01,
      screenshots: [
        AppAssets.shirahSS01,
        AppAssets.shirahSS02,
        AppAssets.shirahSS03,
        AppAssets.shirahSS04,
        AppAssets.shirahSS05,
        AppAssets.shirahSS06,
      ],
      link: 'https://github.com/labib-ur-rahman/#SHIRAH',
      linkLabel: 'GitHub',
    ),

    /// -- Safenex Inspire --
    ProjectModel(
      title: '*Safenex Inspire*: Digital Business & Earning Platform',
      description:
          'Safenex Inspire is a digital business app for earning via product reselling, offers, and micro-jobs, with secure login, offline access, and an admin panel for managing users and payouts.',
      technologies: ['Kotlin', 'XML', 'Firebase', 'RestAPI'],
      image: AppAssets.safenexInsSS01,
      screenshots: [
        AppAssets.safenexInsSS01,
        AppAssets.safenexInsSS02,
        AppAssets.safenexInsSS03,
        AppAssets.safenexInsSS04,
        AppAssets.safenexInsSS05,
        AppAssets.safenexInsSS06,
        AppAssets.safenexInsSS07,
        AppAssets.safenexInsSS08,
      ],
      link: 'https://github.com/labib-ur-rahman/#Safenex-Inspire',
      linkLabel: 'GitHub',
    ),
  
    /// -- JED Rapid Intel --
    ProjectModel(
      title:
          '*JED Rapid Intel*: Logistics Dispatch & Live Driver Tracking System',
      description:
          'A logistics management system where dispatchers create and assign delivery loads, and drivers complete deliveries while being tracked in real time through live map location monitoring.',
      technologies: ['Flutter', 'Dart', 'Google Maps API', 'RestAPI'],
      image: AppAssets.jedSS01,
      screenshots: [
        AppAssets.jedSS01,
        AppAssets.jedSS02,
        AppAssets.jedSS03,
        AppAssets.jedSS04,
        AppAssets.jedSS05,
      ],
      link: 'https://github.com/labib-ur-rahman/#JED-Rapid-Intel',
      linkLabel: 'GitHub',
    ),

    /// -- Smart Engineer --
    ProjectModel(
      title:
          '*Smart Engineer*: BTEB Polytechnic Student Academic Companion App',
      description:
          'All-in-one academic app for BTEB polytechnic engineering students with textbooks, tools, and notices in one place.',
      technologies: ['Kotlin', 'XML', 'Firebase', 'RestAPI'],
      image: AppAssets.smartEngineerSS01,
      screenshots: [
        AppAssets.smartEngineerSS01,
        AppAssets.smartEngineerSS02,
        AppAssets.smartEngineerSS03,
        AppAssets.smartEngineerSS04,
        AppAssets.smartEngineerSS05,
        AppAssets.smartEngineerSS06,
        AppAssets.smartEngineerSS07,
        AppAssets.smartEngineerSS08,
      ],
      link: 'https://github.com/labib-ur-rahman/Smart-Engineer-App',
      linkLabel: 'GitHub',
    ),
];

  void changePage(int index) {
    stopAutoScroll();
    currentPage.value = index;
    resumeAutoScroll();
  }

  void nextProject() {
    stopAutoScroll();
    if (currentPage.value < projects.length - 1) {
      currentPage.value++;
    }
    resumeAutoScroll();
  }

  void previousProject() {
    stopAutoScroll();
    if (currentPage.value > 0) {
      currentPage.value--;
    }
    resumeAutoScroll();
  }

  void selectProject(int index) {
    selectedProjectIndex.value = index;
  }
}
