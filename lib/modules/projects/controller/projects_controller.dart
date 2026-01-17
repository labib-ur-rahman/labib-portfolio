import 'dart:async';
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
    ProjectModel(
      title: '*Deep Quran*: All-in-one platform for Quran reading',
      description:
          'Comprehensive Islamic app featuring Quran reading, translations, audio recitations, and daily prayers',
      technologies: ['Flutter', 'Firebase', 'Dart', 'SQLite'],
      image: 'assets/images/project1.png',
      screenshots: [
        'assets/screenshorts/DeepQuranSS-01.png',
        'assets/screenshorts/DeepQuranSS-02.png',
        'assets/screenshorts/DeepQuranSS-03.png',
        'assets/screenshorts/DeepQuranSS-04.png',
        'assets/screenshorts/DeepQuranSS-05.png',
        'assets/screenshorts/DeepQuranSS-06.png',
        'assets/screenshorts/DeepQuranSS-07.png',
      ],
      link: 'https://example.com/deep-quran',
      linkLabel: 'Play Store',
      isPublished: true,
    ),
    ProjectModel(
      title: '*FoodHub*: Restaurant Delivery Platform',
      description:
          'On-demand food delivery app connecting restaurants with hungry customers',
      technologies: ['Flutter', 'Firebase', 'Dart', 'RestAPI'],
      image: 'assets/images/project1.png',
      screenshots: [
        'assets/screenshorts/DeepQuranSS-01.png',
        'assets/screenshorts/DeepQuranSS-02.png',
        'assets/screenshorts/DeepQuranSS-03.png',
        'assets/screenshorts/DeepQuranSS-04.png',
        'assets/screenshorts/DeepQuranSS-05.png',
      ],
      link: 'https://example.com/foodhub',
      linkLabel: 'GitHub',
    ),
    ProjectModel(
      title: '*HealthTrack*: Medical Record Management',
      description:
          'Digital health records platform for hospitals and clinics with secure data management',
      technologies: ['Flutter', 'SQL', 'Dart', 'PHP'],
      image: 'assets/images/project1.png',
      screenshots: [
        'assets/screenshorts/DeepQuranSS-02.png',
        'assets/screenshorts/DeepQuranSS-03.png',
        'assets/screenshorts/DeepQuranSS-04.png',
        'assets/screenshorts/DeepQuranSS-05.png',
      ],
      link: 'https://example.com/healthtrack',
      linkLabel: 'GitHub',
    ),
    ProjectModel(
      title: '*ShopEase*: E-commerce Mobile App',
      description:
          'Full-featured shopping app with payment integration and inventory management',
      technologies: ['Flutter', 'Kotlin', 'Dart', 'SQL'],
      image: 'assets/images/project1.png',
      screenshots: [
        'assets/screenshorts/DeepQuranSS-03.png',
        'assets/screenshorts/DeepQuranSS-04.png',
        'assets/screenshorts/DeepQuranSS-05.png',
        'assets/screenshorts/DeepQuranSS-06.png',
      ],
      link: 'https://example.com/shopease',
      linkLabel: 'GitHub',
    ),
    ProjectModel(
      title: '*TravelMate*: Trip Planning & Booking',
      description:
          'Comprehensive travel companion with booking, itinerary planning, and local recommendations',
      technologies: ['Flutter', 'Firebase', 'Dart', 'RestAPI'],
      image: 'assets/images/project1.png',
      screenshots: [
        'assets/screenshorts/DeepQuranSS-04.png',
        'assets/screenshorts/DeepQuranSS-05.png',
        'assets/screenshorts/DeepQuranSS-06.png',
        'assets/screenshorts/DeepQuranSS-07.png',
      ],
      link: 'https://example.com/travelmate',
      linkLabel: 'GitHub',
    ),
    ProjectModel(
      title: '*ShopEase*: E-commerce Mobile App',
      description:
          'Full-featured shopping app with payment integration and inventory management',
      technologies: ['Flutter', 'Kotlin', 'Dart', 'SQL'],
      image: 'assets/images/project1.png',
      screenshots: [
        'assets/screenshorts/DeepQuranSS-03.png',
        'assets/screenshorts/DeepQuranSS-04.png',
        'assets/screenshorts/DeepQuranSS-05.png',
        'assets/screenshorts/DeepQuranSS-06.png',
      ],
      link: 'https://example.com/shopease',
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
