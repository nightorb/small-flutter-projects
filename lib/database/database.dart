// ignore_for_file: avoid_print

import 'package:hive_flutter/hive_flutter.dart';
import 'package:small_projects/models/todo_database.dart';

Future<void> main() async {
  
  // Initialisierung von Hive in Kombination mit Flutter
  await Hive.initFlutter();

  // Öffnen der Box
  await Hive.openBox('todoBox');

  TodoDatabase db = TodoDatabase();

  print('todoList: ${db.todoList}');
  db.todoList.add('Einkaufen');
  print('todoList updated: ${db.todoList}');

  db.todoList.insert(0, 'Gaia baden');
  print('todoList: ${db.todoList}');

  db.todoList.removeAt(1);
  print('todoList: ${db.todoList}');

  // Erst hier werden die Daten in die Datenbank geschrieben
  // Update funktioniert nicht alleine in dieser Datei,
  // sondern braucht mehr Resourcen von Flutter
  db.updateDatabase();
}