import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'boasVindas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "teste",
      home: LoginPage(),
    );
  }
}
