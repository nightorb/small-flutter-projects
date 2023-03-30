// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/character.dart';
import '../variables/lists.dart';
import '../widgets/custom_drawer.dart';

class VillainsScreen extends StatefulWidget {
  const VillainsScreen({super.key});

  @override
  State<VillainsScreen> createState() => _VillainsScreenState();
}

class _VillainsScreenState extends State<VillainsScreen> {
  late List<Character> villainsList = [];

  @override
  void initState() {
    super.initState();
    villainsList = villains;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Villains'),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 90.h,
              width: 90.w,
              child: ListView.builder(
                itemCount: villainsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      color: Colors.grey[800],
                      padding: EdgeInsets.all(15),
                      alignment: Alignment.centerLeft,
                      child: ListTile(
                        leading: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(villainsList[index].image),
                              fit: BoxFit.cover
                            ),
                          ),
                        ),
                        title: Text(villainsList[index].name),
                        // tileColor: Colors.grey[800],
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}