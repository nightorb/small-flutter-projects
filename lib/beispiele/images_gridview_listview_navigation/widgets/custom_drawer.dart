// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:small_projects/beispiele/images_gridview_listview_navigation/screens/home_screen.dart';

import '../screens/villains_screen.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 40.w,
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/image1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            // Widget zum Navigieren nach 'home screen'
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Container(
                color: Colors.deepOrange,
                height: 5.h,
                width: 20.w,
                child: Text('Avengers'),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            // Widget zum Navigieren nach 'second screen'
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => VillainsScreen()));
              },
              child: Container(
                color: Colors.deepOrange,
                height: 5.h,
                width: 20.w,
                child: Text('Villains'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
