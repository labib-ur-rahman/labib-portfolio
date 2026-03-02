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
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final experienceKey = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final contactKey = GlobalKey();

  // Navigation items
  final List<String> navItems = [
    'Home',
    'About',
    'Experience',
    'Projects',
    'Skills',
    'Contact',
  ];

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

    GlobalKey? targetKey;
    switch (index) {
      case 0:
        targetKey = homeKey;
        break;
      case 1:
        targetKey = aboutKey;
        break;
      case 2:
        targetKey = experienceKey;
        break;
      case 3:
        targetKey = projectsKey;
        break;
      case 4:
        targetKey = skillsKey;
        break;
      case 5:
        targetKey = contactKey;
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
    // Scroll to projects section
    if (projectsKey.currentContext != null) {
      Scrollable.ensureVisible(
        projectsKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  void onHireMeTap() {
    // Scroll to contact section
    if (contactKey.currentContext != null) {
      Scrollable.ensureVisible(
        contactKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
}
