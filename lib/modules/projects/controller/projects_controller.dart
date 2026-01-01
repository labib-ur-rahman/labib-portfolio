import 'dart:async';
import 'package:get/get.dart';

class ProjectModel {
  final String title;
  final String description;
  final List<String> platforms;
  final List<String> technologies;
  final String image;
  final String? link;

  ProjectModel({
    required this.title,
    required this.description,
    required this.platforms,
    required this.technologies,
    required this.image,
    this.link,
  });
}

class ProjectsController extends GetxController {
  final currentPage = 0.obs;
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
    ProjectModel(
      title: '*Design Unraveled*: Behind the Scenes of UI/UX Magic',
      description:
          'A comprehensive design exploration showcasing modern UI/UX principles and creative workflows',
      platforms: ['Android', 'iOS'],
      technologies: ['Flutter', 'Firebase', 'Dart'],
      image: 'assets/images/project1.png',
      link: 'https://example.com/project1',
    ),
    ProjectModel(
      title: '*Sugee*: Loan Management System for Rural Sector',
      description:
          'Revolutionary loan management platform designed specifically for rural banking operations',
      platforms: ['Android'],
      technologies: ['Flutter', 'Dart', 'RestAPI'],
      image: 'assets/images/project2.png',
      link: 'https://example.com/project2',
    ),
    ProjectModel(
      title: '*Cinetrade*: Innovative way to invest in Digital Media',
      description:
          'Investment platform connecting digital media creators with investors through blockchain',
      platforms: ['Android', 'iOS', 'Web'],
      technologies: ['Flutter', 'Kotlin', 'Dart'],
      image: 'assets/images/project3.png',
      link: 'https://example.com/project3',
    ),
    ProjectModel(
      title: '*FoodHub*: Restaurant Delivery Platform',
      description:
          'On-demand food delivery app connecting restaurants with hungry customers',
      platforms: ['Android', 'iOS', 'Web'],
      technologies: ['Flutter', 'Firebase', 'Dart', 'RestAPI'],
      image: 'assets/images/project4.png',
      link: 'https://example.com/project4',
    ),
    ProjectModel(
      title: '*HealthTrack*: Medical Record Management System',
      description:
          'Digital health records platform for hospitals and clinics with secure data management',
      platforms: ['Android', 'iOS', 'Linux', 'Windows'],
      technologies: ['Flutter', 'SQL', 'Dart', 'PHP'],
      image: 'assets/images/project5.png',
      link: 'https://example.com/project5',
    ),
    ProjectModel(
      title: '*EduLearn*: Online Learning Platform',
      description:
          'Interactive e-learning platform with live classes and course management',
      platforms: ['Android', 'iOS', 'Web', 'MacOS'],
      technologies: ['Flutter', 'Firebase', 'Dart', 'RestAPI'],
      image: 'assets/images/project6.png',
      link: 'https://example.com/project6',
    ),
    ProjectModel(
      title: '*ShopEase*: E-commerce Mobile App',
      description:
          'Full-featured shopping app with payment integration and inventory management',
      platforms: ['Android', 'iOS'],
      technologies: ['Flutter', 'Kotlin', 'Dart', 'SQL'],
      image: 'assets/images/project7.png',
      link: 'https://example.com/project7',
    ),
    ProjectModel(
      title: '*TravelMate*: Trip Planning & Booking App',
      description:
          'Comprehensive travel companion with booking, itinerary planning, and local recommendations',
      platforms: ['Android', 'iOS', 'Web'],
      technologies: ['Flutter', 'Firebase', 'Dart', 'RestAPI'],
      image: 'assets/images/project8.png',
      link: 'https://example.com/project8',
    ),
    ProjectModel(
      title: '*FitnessPro*: Workout & Nutrition Tracker',
      description:
          'Personal fitness coach app with workout plans, nutrition tracking, and progress analytics',
      platforms: ['Android', 'iOS', 'Windows', 'MacOS'],
      technologies: ['Flutter', 'SQL', 'Dart', 'PHP', 'RestAPI'],
      image: 'assets/images/project9.png',
      link: 'https://example.com/project9',
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
}
