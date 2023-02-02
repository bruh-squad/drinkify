import 'package:flutter/material.dart';

class Theming {
  Theming._();
  //0xFF0EE416
  //0xFF21A179
  //0xFFEE6352
  //0xFFCEFF1A tak
  //0xFF0EB1D2 2 tak
  //0xFF7D01B3 0.75 tak
  static const Color primaryColor = Color(0xFF0EB1D2);
  static const Color bgColor = Color(0xFF011936);
  static const Color whiteTone = Color.fromARGB(255, 255, 255, 255);
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
    fontWeight: FontWeight.bold
  );

  static const hintTextSearchBar = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const dateTextSelected = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Theming.primaryColor,
  );

  static const dateTextUnselected = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Theming.whiteTone,
  );
}