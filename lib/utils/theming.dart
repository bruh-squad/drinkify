import 'package:flutter/material.dart';

class Theming {
  Theming._();

  static const Color primaryColor = Color.fromARGB(255, 246, 70, 64);
  static const Color bgColor = Color.fromARGB(255, 1, 25, 54);
  static const Color whiteTone = Color.fromARGB(255, 247, 244, 243);
}

class Styles {
  Styles._();
  
  static const navBarText = TextStyle(
    color: Theming.whiteTone,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const categoryText = TextStyle(
    color: Theming.whiteTone,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final smallTextButton = TextStyle(
    color: Theming.whiteTone.withOpacity(0.7),
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const dateBoxText = TextStyle(
    color: Theming.whiteTone,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static final emptyListText = TextStyle(
    color: Theming.whiteTone.withOpacity(0.7),
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const hintTextSearchBar = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

}