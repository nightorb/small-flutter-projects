import 'dart:math';
import 'package:flutter/material.dart';

class RegionContainer extends StatefulWidget {
  const RegionContainer({super.key});

  @override
  State<RegionContainer> createState() => _RegionContainerState();
}

class _RegionContainerState extends State<RegionContainer> {
    final _random = Random();

    final List<String> regions = [
    'Finsterwald',
    'Tal der Verdammnis',
    'Goldhain',
    'Nebelpfad',
    'Mondberg',
    'Rote Wüste',
    'Grüne Heide',
  ];

  late int startRegion;
  late int currentRegion;

  late String narrative;

  _RegionContainerState() {
    startRegion = _random.nextInt(regions.length);
    currentRegion = regions.indexOf(regions[startRegion]);

    switch(startRegion) {
      case 0:
      case 1:
      case 2:
        narrative = 'Deine epische Reise startet im ${regions[startRegion]}.';
        break;
      case 3:
      case 4:
        narrative = 'Deine epische Reise startet auf dem ${regions[startRegion]}.';
        break;
      case 5:
        narrative = 'Deine epische Reise startet in der Roten Wüste.';
        break;
      case 6:
        narrative = 'Deine epische Reise startet auf der Grünen Heide.';
        break;
      default:
        narrative = 'Du hast noch nicht gestartet.';
    }
  }

  void move() {
    int newRegion = _random.nextInt(regions.length);
    int regionIndex = regions.indexOf(regions[newRegion]);

    if (newRegion == currentRegion) {

      switch(currentRegion) {
        case 0:
          narrative =
            'Der Finsterwald ist zwar ziemlich gruselig, '
            'aber du möchtest ihn noch weiter erkunden.';
          break;
        case 1:
          narrative = 'Das Tal der Verdammnis zieht dich immer weiter in die Verdammnis.';
          break;
        case 2:
          narrative =
            'Der Goldhain ist so friedlich und ruhig. '
            'Du möchtest lieber noch ein bisschen bleiben.';
          break;
        case 3:
          narrative = 'Du scheinst dich auf dem gefährlichen Nebelpfad verirrt zu haben.';
          break;
        case 4:
          narrative =
            'Der Mondberg ist ein sehr mystischer Ort.'
            'Vielleicht findest du hier noch wertvolle Schätze.';
          break;
        case 5:
          narrative =
            'In der Roten Wüste ist es so heiß und trocken, '
            'dass du vor Erschöpfung kaum voran kommst.';
          break;
        case 6:
          narrative =
            'Die Grüne Heide ist der perfekte Ort, '
            'um kurz innezuhalten und die Wolken zu beobachten.';
          break;
        default:
          narrative = 'Du entscheidest dich, etwas länger an diesem Ort zu bleiben.';
      }

    } else {

      switch(currentRegion) {
        case 0:
          narrative = 
            'Im Finsterwald hast du nichts besonderes gefunden. '
            'Du ziehst weiter in Richtung ${regions[newRegion]}.';
          break;
        case 1:
          narrative =
            'Das Tal der Verdammnis hätte dich fast deinen Verstand gekostet '
            '- zum Glück hast du es noch rechtzeitig herausgeschafft. '
            'Du setzt deinen Weg fort und entdeckst '
            '${regionIndex == 0 || regionIndex == 2 || regionIndex == 3 || regionIndex == 4
              ? 'den ${regions[newRegion]}'
              : 'die ${regions[newRegion]}'
            }.';
          break;
        case 2:
          narrative =
            'Die Magie des Goldhains hat dir Kraft gegeben. '
            'Du setzt du deinen Weg fort und erreichst '
            '${regionIndex == 0 || regionIndex == 3 || regionIndex == 4
              ? 'den ${regions[newRegion]}'
              : regionIndex == 1 ? 'das ${regions[newRegion]}' : 'die ${regions[newRegion]}'
            }.';
          break;
        case 3:
          narrative = 
            'Nach langem Umherirren verlässt du endlich den Nebelpfad. '
            'Dein Weg führt dich '
            '${regionIndex == 0 || regionIndex == 1 || regionIndex == 2 || regionIndex == 4
              ? 'zum ${regions[newRegion]}'
              : regionIndex == 5 ? 'in die ${regions[newRegion]}' : 'auf die ${regions[newRegion]}'
            }.';
          break;
        case 4:
          narrative =
            'Vom Mondberg aus ziehst du weiter '
            '${regionIndex == 0 || regionIndex == 1 || regionIndex == 2 || regionIndex == 3
              ? 'zum ${regions[newRegion]}'
              : regionIndex == 5 ? 'in die ${regions[newRegion]}' : 'auf die ${regions[newRegion]}'
            }.';
          break;
        case 5:
          narrative =
            'Du bist froh, die sengende Hitze der Roten Wüste überlebt zu haben. '
            'Völlig erschöpft kommst du '
            '${regionIndex == 0 || regionIndex == 1 || regionIndex == 2
              ? 'im ${regions[newRegion]} an'
              : regionIndex == 3 || regionIndex == 4 ? 'auf dem ${regions[newRegion]} an' : 'auf die ${regions[newRegion]}'
            }.';
          break;
        case 6:
          narrative =
            'Die Grüne Heide lädt zwar zum Träumen ein, '
            'doch das Abenteuer ruft! '
            'Du verlässt die Grüne Heide und kurze Zeit später hast du '
            '${regionIndex == 0 || regionIndex == 2 || regionIndex == 3 || regionIndex == 4
              ? 'den ${regions[newRegion]}'
              : regionIndex == 1 ? 'das ${regions[newRegion]}' : 'die ${regions[newRegion]}'
            } vor dir.';
          break;
        default:
          narrative = 'Du entscheidest dich, etwas länger an diesem Ort zu bleiben.';
      }
    }

    setState(() {
      currentRegion = newRegion;
      narrative;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            narrative,
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: move,
            child: Container(
              width: 300,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 226, 141, 14),
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
              ),
              child: const Icon(
                Icons.explore,
                size: 72,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}