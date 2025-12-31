import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/theme_controller.dart';

class AboutController extends GetxController {
  // Navigation
  final RxInt selectedNavIndex = 0.obs;
  final RxInt hoveredNavIndex = (-1).obs;

  // Animation states
  final RxBool showContent = false.obs;
  final RxBool showProfile = false.obs;
  final RxBool showDecorations = false.obs;

  // Theme controller
  final themeController = Get.put(ThemeController());

  // Scroll keys for navigation
  final aboutKey = GlobalKey();
  final servicesKey = GlobalKey();
  final experienceKey = GlobalKey();
  final skillsKey = GlobalKey();

  // Navigation items
  final List<String> navItems = ['About', 'Services', 'Experience', 'Skills'];

  @override
  void onInit() {
    super.onInit();
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    showContent.value = true;

    await Future.delayed(const Duration(milliseconds: 200));
    showProfile.value = true;

    await Future.delayed(const Duration(milliseconds: 200));
    showDecorations.value = true;
  }

  void onNavItemTap(int index) {
    selectedNavIndex.value = index;

    // Scroll to section
    GlobalKey? targetKey;
    switch (index) {
      case 0:
        targetKey = aboutKey;
        break;
      case 1:
        targetKey = servicesKey;
        break;
      case 2:
        targetKey = experienceKey;
        break;
      case 3:
        targetKey = skillsKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void onNavHover(int index) {
    hoveredNavIndex.value = index;
  }

  void clearNavHover() {
    hoveredNavIndex.value = -1;
  }

  void onPortfolioTap() {
    // Navigate to portfolio section
    Get.snackbar(
      'Portfolio',
      'Navigating to Portfolio section',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onHireMeTap() {
    // Navigate to contact or hire me section
    Get.snackbar(
      'Hire Me',
      'Navigating to Contact section',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
