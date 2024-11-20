import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midterm/pages/home.dart';
import 'package:midterm/pages/detail.dart';
import 'package:midterm/pages/list.dart';

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
        fontFamily: 'suwannaphum', // Replace with your desired font family
      ),

      home: Home(),
      routes: {
          '/homepage':(context) => const Home(),
      },
    );}}