import 'package:crud_app/view/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent.shade400,
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: Colors.blueAccent.shade400,
        fontFamily: "Lexend",
      ),
      home: const MainScreen(),
    );
  }
}
