import 'package:DeveloperLabib/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/core.dart';
import 'modules/about/screen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ThemeController globally
    final themeController = Get.put(ThemeController());

    return GetMaterialApp(
      title: 'Developer Labib',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeController.themeMode,
      defaultTransition: Transition.fadeIn,
      home: const HomeScreen(),
    );
  }
}
