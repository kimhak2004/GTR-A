import 'package:flutter/material.dart';
import 'cv_page.dart';
import 'models.dart';

void main() {
  runApp(const CVApp());
}

class CVApp extends StatelessWidget {
  const CVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Professional CV - ${CVData.fullName}',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        // Modern Minimalist Color Scheme
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00D9FF), // Teal accent
          onPrimary: Color.fromARGB(255, 74, 225, 252), // Deep charcoal
          surface: Color(0xFF0F0F0F), // Deep charcoal background
          onSurface: Color(0xFFFFFFFF), // White text
          surfaceContainerHighest: Color.fromARGB(255, 255, 254, 254), // Card background
          outline: Color(0xFF2A2A2A), // Border color
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 26, 192, 237),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 253, 252, 252),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color.fromARGB(255, 247, 245, 245),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'IBMPlexSerif',
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            fontFamily: 'IBMPlexSerif',
          ),
          displayMedium: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            fontFamily: 'IBMPlexSerif',
          ),
          displaySmall: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            fontFamily: 'IBMPlexSerif',
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            fontFamily: 'IBMPlexSerif',
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
            fontFamily: 'IBMPlexSerif',
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF),
            fontFamily: 'IBMPlexSans',
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
            fontFamily: 'IBMPlexSans',
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFFE0E0E0),
            fontFamily: 'IBMPlexSans',
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            color: Color(0xFFB0B0B0),
            fontFamily: 'IBMPlexSans',
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color.fromARGB(255, 3, 3, 3),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 1,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1A1A1A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF2A2A2A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF00D9FF), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFFB0B0B0)),
          hintStyle: const TextStyle(color: Color(0xFF3A3A3A)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00D9FF),
            foregroundColor: const Color(0xFF0F0F0F),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'IBMPlexSans',
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
            side: const BorderSide(color: Color.fromARGB(255, 9, 22, 25), width: 1),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const CVPage(),
    );
  }
}
