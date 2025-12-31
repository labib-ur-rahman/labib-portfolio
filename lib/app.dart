import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/core.dart';
import 'modules/about/screen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Md Labibur Rahman - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.fadeIn,
      home: const HomeScreen(),
    );
  }
}
