// Beispiel Startscreen der Cimdata-App

import 'package:flutter/material.dart';
import 'custom_widgets/container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  void increaseCounter() {
    setState(() {
      counter++;
    });
  }

  void decreaseCounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold = SeitenTemplate von Google
    return Scaffold(
      appBar: AppBar(
        title: const Text("mein.cimdata"),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Container(
          // double.infinity = der zur Verfügung stehende Raum
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: const Color.fromARGB(255, 241, 233, 233),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              // Oberste Reihe (3 x gesturedetector)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: increaseCounter,
                    child: const MenuContainer(
                      menuLabel: 'WEBSITE',
                      menuIcon: Icons.aod_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: decreaseCounter,
                    child: const MenuContainer(
                      menuLabel: 'ANRUFEN',
                      menuIcon: Icons.call_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const MenuContainer(
                      menuLabel: 'EMAIL',
                      menuIcon: Icons.mail_outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {},
                child: Container(
                  color: Colors.pink,
                  width: double.infinity,
                  height: 400,
                  child: Center(
                    child: Text(
                      '$counter',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [Text("Impressum"), Text("Datenschutz")],
              )
            ],
          ),
        ),
      ),
    );
  }
}
