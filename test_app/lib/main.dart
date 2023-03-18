import 'package:flutter/material.dart';
import 'package:test_app/screens/counter_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test App',
      showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      home: CounterScreen()
    );
  }
}