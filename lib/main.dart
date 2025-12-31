import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations for web
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const MyApp());
}
