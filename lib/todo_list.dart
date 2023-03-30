import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'database/models/todo_database.dart';

// App im Emulator starten, damit Hive funktioniert

Future<void> main() async {
  // Hive innerhalb von main() initialieren
  await Hive.initFlutter();

  // Box öffnen
  await Hive.openBox('todoBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const TodoList(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.blue,
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // Ohne Hive:
  // List todos = [
  //   'Rasen mähen',
  //   'Geld überweisen',
  //   'Katze füttern',
  //   'Spülmaschiene ausräumen',
  // ];

  // Mit Hive:
  final todoBox = Hive.box('todoBox');
  TodoDatabase db = TodoDatabase();

  // mit initState werden Daten in db geladen
  @override
  void initState() {
    if (todoBox.get('TODOLIST') != null) {
      // wenn Box nicht leer ist, lade bestehende Datenbank
      db.loadDatabase();
    }

    super.initState();
  }

  String userInput = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: ListView.builder(
          // itemCount: todos.length, // ohne Hive
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            // einzigartigen Key erzeugen, um das jeweilige Element identifizieren zu können
            Key myKey = UniqueKey();

            return Dismissible(
              background: Container(
                color: Colors.red,
              ),
              direction: DismissDirection.endToStart,
              key: myKey,
              child: Card(
                child: ListTile(
                  // title: Text(todos.elementAt(index)), // ohne Hive
                  title: Text(db.todoList[index]),
                ),
              ),
              onDismissed: (direction) {
              // String wird zwischensgepeichert für Undo-Möglichkeit
                // String deleted = todos.removeAt(index); // ohne Hive

                String deleted = db.todoList.removeAt(index); // mit Hive
                setState(() {
                  db;
                });

                // Todo wird aus der Liste "db" gelöscht
                // -> mit updateDatabase() wird der Speicher entsprechend aktualisiert
                db.updateDatabase();

                // Snackbar für Undo-Möglichkeit
                SnackBar snackbar = SnackBar(
                  content: const Text('Aufgabe erledigt'),
                  action: SnackBarAction(
                    label: 'Rückgängig',
                    onPressed: () {
                      setState(() {
                        // todos.insert(index, deleted); // ohne Hive

                        // am alten index den widerrufenen String hinzufügen
                        db.todoList.insert(index, deleted); // mit Hive
                      });
                      db.updateDatabase();
                    }
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              },
            );
        }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Todo hinzufügen'),
                  content: TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Bitte eintragen',
                    ),
                    onChanged: (String value) {
                      userInput = value;
                    },
                    onSubmitted: (String input) => addNewItem(context),
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        if (userInput != '') {
                          setState(() {
                            userInput = '';
                          });
                        }
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Abbrechen',
                      ),
                    ),
                    MaterialButton(
                      onPressed: () => addNewItem(context),
                      color: Colors.green,
                      child: const Text(
                        'Hinzufügen',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ]);
              });
          },
        ),
      );
  }

  void addNewItem(BuildContext context) {
    if (userInput != '') {
      setState(() {
        // todos.add(userInput); // ohne Hive

        db.todoList.add(userInput); // mit Hive
        userInput = '';
      });
    }
    Navigator.pop(context);
  }
}