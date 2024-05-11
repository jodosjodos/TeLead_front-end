import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:te_lead/pages/landing_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(
    fileName: '.env',
  );
  HttpOverrides.global = MyHttpOverrides();

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
          tertiary: const Color.fromRGBO(84, 84, 84, 1),
        ),
        textTheme: TextTheme(
          titleMedium: GoogleFonts.jost(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.jost(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.mulish(
            fontWeight: FontWeight.bold,
          ),
          titleSmall: GoogleFonts.mulish(),
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
