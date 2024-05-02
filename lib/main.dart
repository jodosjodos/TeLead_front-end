import 'package:flutter/material.dart';
import 'package:te_lead/pages/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LeLead",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(9, 97, 245, 1),
          primary: const Color.fromRGBO(9, 97, 245, 1),
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
