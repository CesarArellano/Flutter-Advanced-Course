import 'package:flutter/material.dart';

import 'package:new_states_app/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      theme: ThemeData.light(useMaterial3: true),
      routes: {
        'home': (_) => const HomeScreen(),
        'detail': (_) => const DetailScreen()
      },
    );
  }
}

