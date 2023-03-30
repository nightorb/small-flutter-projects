// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:small_projects/beispiele/packages_navigation_images/screens/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Anzeigen eines neuen Screens
            // '.push' -> der folgende Screen wird auf einen "Screen-Stapel" oben drauf gelegt
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SecondScreen(meinText: 'Back to Home',)));
          },
          child: Container(
            color: Colors.deepPurple[300],
            height: 10.h,
            width: 30.w,
            child: Center(
              child: Text(
                'Go to SecondScreen',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}