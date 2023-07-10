import 'package:base_app_july/pages/todo_list_screen/todo_list_page.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF9900),
          background: const Color(0xFFEDEDED),
          primary: const Color(0xFFFF9900),
          secondary: const Color(0xFF45B443),
          error: const Color(0xFFF85535),
          surface: const Color(0xFFFFFFFF),
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            height: 14 / 20,
            color: Color(0xFF000000),
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          bodyLarge: TextStyle(
            color: Color(0xFFF85535),
            height: 16 / 20,
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 32 / 24,
          ),
        ),
      ),
      home: const ToDoListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
