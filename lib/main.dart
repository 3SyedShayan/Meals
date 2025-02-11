import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/screens/home.dart';
import 'package:meals/screens/tab.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 131, 57, 0),
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: TabScreen(),
    );
  }
}
