import 'dart:async';
import 'package:get/get.dart';
import '../../../core/core.dart';

class ServicesController extends GetxController {
  final RxInt currentPage = 0.obs;
  final RxBool isAnimating = false.obs;
  Timer? _autoScrollTimer;

  // Services data - 5 services
  final List<ServiceModel> services = [
    ServiceModel(
      title: 'UI/UX Design',
      description: 'Creating intuitive and beautiful user interfaces',
      imagePath: AppAssets.rectangle7,
    ),
    ServiceModel(
      title: 'Web Design',
      description: 'Responsive and modern web design solutions',
      imagePath: AppAssets.rectangle8,
    ),
    ServiceModel(
      title: 'Landing Page',
      description: 'High-converting landing pages for your business',
      imagePath: AppAssets.rectangle7,
    ),
    ServiceModel(
      title: 'Mobile App',
      description: 'Cross-platform mobile applications with Flutter',
      imagePath: AppAssets.rectangle8,
    ),
    ServiceModel(
      title: 'Branding',
      description: 'Complete branding and visual identity design',
      imagePath: AppAssets.rectangle7,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _startAutoScroll();
  }

  @override
  void onClose() {
    _autoScrollTimer?.cancel();
    super.onClose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currentPage.value < services.length - 1) {
        currentPage.value++;
      } else {
        currentPage.value = 0;
      }
    });
  }

  void changePage(int index) {
    currentPage.value = index;
    // Restart auto-scroll timer when user manually changes page
    _autoScrollTimer?.cancel();
    _startAutoScroll();
  }

  void nextPage() {
    if (currentPage.value < services.length - 1) {
      currentPage.value++;
    } else {
      currentPage.value = 0;
    }
    _autoScrollTimer?.cancel();
    _startAutoScroll();
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    } else {
      currentPage.value = services.length - 1;
    }
    _autoScrollTimer?.cancel();
    _startAutoScroll();
  }
}

class ServiceModel {
  final String title;
  final String description;
  final String imagePath;

  ServiceModel({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}
