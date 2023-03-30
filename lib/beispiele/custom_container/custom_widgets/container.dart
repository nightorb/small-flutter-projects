// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MenuContainer extends StatelessWidget {
  final String menuLabel;
  final IconData menuIcon;
  
  const MenuContainer({super.key, required this.menuLabel, required this.menuIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 110,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        // gradient: RadialGradient(
        //   radius: 6,
        //   colors: [
        //     Colors.blueGrey,
        //     Colors.pink,
        //   ],
        // ),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(0.5, 1.5),
            spreadRadius: 0.25,
          ),
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 10,
          ),
          Icon(
            menuIcon,
            size: 100,
            color: Colors.white,
          ),
          Text(
            menuLabel,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
