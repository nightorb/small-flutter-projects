// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SuccessScreen extends StatefulWidget {
  final String value;

  const SuccessScreen(this.value, {super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Screen'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Text(widget.value),
        ],
      ),
    );
  }
}