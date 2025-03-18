import 'package:flutter/material.dart';
import 'package:tuan3_bai3/screen/home_screen.dart';
import 'package:tuan3_bai3/screen/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home', 
      routes: {
        '/': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
