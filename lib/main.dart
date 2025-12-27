import 'package:flutter/material.dart';
import 'package:laablume/screens/main_navigation_screen.dart';

void main() {
  runApp(const LabLumeApp());
}

class LabLumeApp extends StatelessWidget {
  const LabLumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigationScreen(), // Bottom navigation with all screens
    );
  }
}
