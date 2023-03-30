// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/character.dart';
import '../variables/lists.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Character> heroesList;

  @override
  void initState() {
    super.initState();
    heroesList = heroes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Avengers'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Container(
            height: 40.h,
            // GridView.Builder für unbekannte Menge an darzustellenden Elementen
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2.w,
                    crossAxisSpacing: 2.w,
                    childAspectRatio: 1,
                  ),
              // Anzahl der darzustellenden Elemente (Länge einer initialisierten Liste)
              itemCount: heroesList.length,
              // nur die Elemente laden, die angezeigt werden können
              shrinkWrap: true,
              // Ausrichtung der GridView (horizontal = quer)
              scrollDirection: Axis.horizontal,
              // Prototyp für zu generierende Elemente (Layout)
              itemBuilder: (BuildContext context, int index) {
                // Rückgabe des Prototypen
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      // Anhand des Index der Liste('heroesList) wird jedem Element
                      // der GridView das entsprechende Image angezeigt, welches in dem
                      // entsprechend instanzierten Character-Object hinterlegt ist
                      image: AssetImage(heroesList[index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.black,
                        width: double.infinity,
                        padding: EdgeInsets.all(3.0),
                        child: Center(child: Text(heroesList[index].name))
                      ),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
