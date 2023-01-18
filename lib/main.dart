import 'package:flutter/material.dart';
import './routes/homepage.dart';

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
        primaryColor: const Color.fromRGBO(1, 25, 54, 1),
        accentColor: const Color.fromRGBO(246, 71, 64, 1),
      ),
      home: const HomePage(),
    );
  }
}
