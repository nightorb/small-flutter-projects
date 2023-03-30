// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(const MaterialApp(
    title: 'JSON and Futures',
    home: FuturesApp(
      title: 'JSON and Futures'
    ),
  )); 
}

class FuturesApp extends StatefulWidget {
  final String title;
  
  const FuturesApp({super.key, required this.title});
  // const FuturesApp({Key? key}) : super(key: key);

  @override
  State<FuturesApp> createState() => _FuturesAppState();
}

class _FuturesAppState extends State<FuturesApp> {
  // holt Daten vom Server und gibt diese zurück an den FutureBuilder im Body sobald sie vorliegen
  Future<List<User>> showUsers() async {
    // 1. JSON-Daten per http-Package vom Server holen (HTTP GET request), erhält Antwort vom Server (Response)
    var data = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    // 2. JSON-String aus data.body in eine Liste von Maps umwandeln (jsonDecode())
    var dataDecoded = jsonDecode(data.body);

    // leere Liste "Users" als Platzhalter für User-Objekte
    List<User> users = [];

    // 4. Platzhalter-Liste mit Daten befüllen (durch die keys der Maps)
    dataDecoded.forEach((user) {
      // -> für jeden Datensatz der Liste wird ein User-Objekt zu "users" hinzugefügt
      users.add(User(
        user['name'],
        user['username'],
        user['email'],
        user['phone'],
        user['website'],
        user['company']
      ));
    });

    // 5. Die gefüllte Liste "users" zurückgeben
    print(users[0]);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: showUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          // Check, ob bereits Daten vorliegen
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(snapshot.data![index].username),
                    subtitle: Text(
                      '${snapshot.data![index].name}\n'
                      '${snapshot.data![index].website}'
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) =>
                            UserDetails(
                              title: widget.title,
                              name: snapshot.data![index].name,
                              username: snapshot.data![index].username,
                              email: snapshot.data![index].email,
                              phone: snapshot.data![index].phone,
                              website: snapshot.data![index].website,
                              company: snapshot.data![index].company,
                            )
                          ));
                      },
                      icon: const Icon(Icons.arrow_circle_right_outlined)
                    ),
                  ),
                );
              }
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}

class UserDetails extends StatefulWidget {
  final String title;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Map<String, dynamic> company;

  const UserDetails({
    super.key,
    required this.title,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.company
  });

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.username,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(widget.name),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'email: ${widget.email}\n'
                      'phone number: ${widget.phone}\n\n'
                      'website: ${widget.website}'
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Company information:\n'
                      'name: ${widget.company['name']}\n'
                      'catch phrase: ${widget.company['catchPhrase']}\n'
                      'bs: ${widget.company['bs']}'
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// User-Klasse 
class User {
  String name;
  String username;
  String email;
  String phone;
  String website;

  // mit "Map company = {}" funktioniert es irgendwie nicht, deshalb hier nichts angeben
  Map<String, dynamic> company;

  User(
    this.name,
    this.username,
    this.email,
    this.phone,
    this.website,
    this.company
  );
}