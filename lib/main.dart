import 'package:app_your_banking/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Origem do projeto
// https://www.youtube.com/watch?v=IyFUW7JAvTQ

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: HomeScreen(),
    );
  }
}