import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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
          secondary: const Color.fromRGBO(32, 34, 68, 1),
          background: const Color.fromRGBO(245, 249, 255, 1),
        ),
        textTheme: TextTheme(
          titleLarge: GoogleFonts.jost(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.mulish(
            fontWeight:FontWeight.normal
          )
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
