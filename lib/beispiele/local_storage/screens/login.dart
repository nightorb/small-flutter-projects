// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:small_projects/beispiele/local_storage/screens/success.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {

  // Instanzierung der shared preferences, um Package nutzen zu können
  final Future<SharedPreferences> localStorage = SharedPreferences.getInstance();
  late Future<String> savedInfo;

  // // Future-Function zum einsetzen eines key-value-pairs im local storage (shared preferences)
  // Future<void> setInfo() async {
  //   // Zwischenvariable für localStorage
  //   final SharedPreferences storage = await localStorage;
  //   // Anlegen eines key.value pairs im lokalen Speicher
  //   // key MUSS immer ein String sein
  //   storage.setString('testInfo', 'passwort');

  //   setState(() {
  //     // Dasselbe muss auch im initState() stehen, damit die App auch beim Neustart die gespeicherten Infos anzeigt
  //     savedInfo = localStorage.then((SharedPreferences value) {
  //       return value.getString('testInfo') ?? '';
  //     });
  //   });
  // }

  Future<void> checkTextInput(String value) async {
    final SharedPreferences storage = await localStorage;
    final String? storedInfo = storage.getString('testInfo');

    if (value == storedInfo) {
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SuccessScreen(value)));
    }
  }

  Future<void> saveData(String value) async {
    final SharedPreferences storage = await localStorage;
    storage.setString('testInfo', value);

    setState(() {
      savedInfo = localStorage.then((SharedPreferences value) {
        return value.getString('testInfo') ?? '';
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // der Hilfsvariable wird der value aus unserem key-value pair im lokalen Speicher zugewiesen
    savedInfo = localStorage.then((SharedPreferences value) {
      // ?? '' <- wenn nichts vorhanden, dann leeren String wiedergeben
      return value.getString('testInfo') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       SizedBox(
      //         height: 15.h,
      //       ),
      //       FutureBuilder<String>( // Der Future, der hier gebaut wird soll ein String sein
      //         future: savedInfo, // Quelle aus der heraus gebaut werden soll
      //         builder: ((context, snapshot) {
      //           // snapshot = daten aus dem FutureBuilder-Attribut: 'future'
      //           if (snapshot.data != '') {
      //             // wenn Daten vorhanden, dann die Daten in einem Text-Widget ausgeben
      //             return Text(snapshot.data.toString());
      //           } else {
      //             // wenn Daten noch nicht vorhanden, dann diesen Ersatz
      //             return Text('Keine Informationen vorhanden.');
      //           }
      //         }),
      //       ),
      //       ElevatedButton(
      //         onPressed: setInfo,
      //         child: Text('set info'),
      //       ),
      //       SizedBox(
      //         height: 15.h,
      //       )
      //     ],
      //   ),
      // ),
      body: Column(
        children: [
          FutureBuilder(
            future: savedInfo,
            builder: ((context, snapshot) {
              if (snapshot.data != '') {
                // savedInfo = snapshot.data.toString();
                return Text('gespeicherte Information: ${snapshot.data.toString()}');
              } else {
                return Text('gespeicherte Information: ----');
              }
            })
          ),
          SizedBox(height: 10.h,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'save data',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  saveData(value);
                },
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'check data',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  checkTextInput(value);
                },
              ),
              SizedBox(height: 20,),
            ],
          ),
        ],
      ),
    );
  }
}