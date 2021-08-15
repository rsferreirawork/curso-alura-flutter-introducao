import 'package:amamos_comida/telas/dashboard/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amamos comida',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Home(),
    );
  }
}
