import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:small_projects/beispiele/navigation_aufgabe/screens/info_screen.dart';
import '../custom_widgets/interaction_button.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _random = Random();

  int gainedExp = 0;
  int currentExp = 0;
  List<int> minExp = [150, 350, 600, 900, 1250, 1650, 2100, 2600, 3150, 3750];

  int currentLvl = 0;
  int levelUp = 1;

  String? infoText;

  _HomeScreenState();

  final List<String> locations = [];

  void gainExp() {
    gainedExp = _random.nextInt(150) + 10;
    currentExp += gainedExp;

    levelUpWithExp();

    setState(() {
      gainedExp;
      currentExp;
      currentLvl;
    });
  }

  void levelUpWithExp() {
    if (currentExp >= minExp[0]) {
      if (currentLvl == 0) {
        currentLvl = 1;
      }
      if (currentLvl != 0 && currentExp < 150) {
        currentLvl = currentLvl;
      }
    }
    if (currentExp >= minExp[1]) currentLvl++;
    if (currentExp >= minExp[2]) currentLvl++;
    if (currentExp >= minExp[3]) currentLvl++;
    if (currentExp >= minExp[4]) currentLvl++;
    if (currentExp >= minExp[5]) currentLvl++;
    if (currentExp >= minExp[6]) currentLvl++;
    if (currentExp >= minExp[7]) currentLvl++;
    if (currentExp >= minExp[8]) currentLvl++;
    if (currentExp >= minExp[9]) currentLvl++;
  }

  void levelUpWithPowerUp() {
    setState(() {
      currentLvl++;
    });
  }

  void changeLocation() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            InteractionButton(
              buttonName: 'Exp',
              result: currentExp.toString(),
              onButtonPress: gainExp,
            ),
            InteractionButton(
              buttonName: 'Level',
              result: currentLvl.toString(),
              onButtonPress: levelUpWithPowerUp,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const InfoScreen()));
              },
              child: Container(
                color: Colors.green,
                height: 10.h,
                width: 30.w,
                child: const Text('View player information'),
              ),
            )

          ],
        ),
      ),
    );
  }
}