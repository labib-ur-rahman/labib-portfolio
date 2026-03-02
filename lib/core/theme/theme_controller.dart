import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final RxBool isDarkMode = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Default to dark mode for portfolio
    Get.changeThemeMode(ThemeMode.dark);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  bool get isDark => isDarkMode.value;
}
