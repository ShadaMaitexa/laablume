import 'package:flutter/material.dart';
import 'package:laablume/screens/common/splash_screen.dart';


void main() {
  runApp(const LabLumeApp());
}

class LabLumeApp extends StatelessWidget {
  const LabLumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
