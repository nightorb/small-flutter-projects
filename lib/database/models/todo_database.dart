import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  // Normalerweise wäre es besser, die Liste private machen, damit man sie nicht direkt editieren kann
  // in unserem Beispiel ist es aber nicht schlimm
  List todoList = [];

  // Referenzieren der Hive-Box, um später Daten darin zu speichern
  final _todoBox = Hive.box('todoBox');

  // Daten abrufen (lesen)
  void loadDatabase() {
    todoList = _todoBox.get('TODOLIST');
  }

  // Daten aktualisieren (schreiben)
  void updateDatabase() {
    // dem key "TODOLIST" wird der Wert "todoList" zugeordnet
    _todoBox.put('TODOLIST', todoList); // key-value pair
  }
}
