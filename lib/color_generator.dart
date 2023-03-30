// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  final Future<SharedPreferences> localStorage = SharedPreferences.getInstance();
  Color myColor = Colors.white;

  Future<void> setColor() async {
    final SharedPreferences colorValue = await localStorage;

    int r = Random().nextInt(256);
    int g = Random().nextInt(256);
    int b = Random().nextInt(256);

    setState(() {
      colorValue.setInt('r', r);
      colorValue.setInt('g', g);
      colorValue.setInt('b', b);

      myColor = Color.fromRGBO(r, g, b, 1.0);
    });
  }

  Future<void> _loadLastColor() async {
    final SharedPreferences storedColorValue = await localStorage;
    
    setState(() {
      int r = storedColorValue.getInt('r') ?? 0;
      int g = storedColorValue.getInt('g') ?? 0;
      int b = storedColorValue.getInt('b') ?? 0;

      myColor = Color.fromRGBO(r, g, b, 1.0);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadLastColor();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: myColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.colorize),
                color: Colors.white,
                iconSize: 70.0,
                onPressed: setColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
