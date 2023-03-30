// ignore_for_file: avoid_print

import 'dart:convert'; // benötigt für jsonDecode()
import 'package:http/http.dart' as http;


void main(List<String> arg) async {
  var data = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  print('data: $data'); // Response-Objekt
  print('statuscode: ${data.statusCode}'); // 200: ok
  print('body: ${data.body}'); //
  print('body runtimeType: ${data.body.runtimeType}');

  // JSON-Response in Map umwandeln
  var dataDecoded = jsonDecode(data.body);
  print('dataDecoded: $dataDecoded');
  print('dataDecoded: ${dataDecoded.runtimeType}'); // List<dynamic>
  print(dataDecoded[0]['title']); // Name des ersten Elements
  print(dataDecoded[0]['body']); // nicht dasselbe wie data.body
}
