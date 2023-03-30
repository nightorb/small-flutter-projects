// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SecondScreen extends StatefulWidget {
  final String meinText;

  const SecondScreen({super.key, required this.meinText});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late String aktuellerOrt;

  List meineOrte = ['Berlin', 'Hamburg', 'Stuttgart'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aktuellerOrt = meineOrte[2];
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Zurück zum HomeScreen
                // pop() -> schmeißt den aktuellen Screen vom Screen-Stapel weg,
                // sodass man wieder zum vorherigen Screen kommt
                Navigator.of(context).pop();
              },
              child: Container(
                color: Colors.amber[600],
                height: 10.h,
                width: 30.w,
                child: Center(
                  child: Text(
                    widget.meinText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            GestureDetector(
              onTap: () {
                
              },
              child: Container(
                color: Colors.lightBlue,
                width: 20.w,
                height: 10.h,
                child: Center(
                  child: Text(
                    aktuellerOrt,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}