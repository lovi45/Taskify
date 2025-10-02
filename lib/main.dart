import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(const TaskifyApp());
}

class TaskifyApp extends StatelessWidget {
  const TaskifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taskify',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(), // pehle splash screen open hoga
    );
  }
}
