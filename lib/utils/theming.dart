import 'package:flutter/material.dart';

class Theming {
  Theming._();

  static const Color primaryColor = Color(0xFFFF0F5C);
  static const Color bgColorLight = Color(0xFF002552);
  static const Color bgColor = Color(0xFF011936);
  static const Color whiteTone = Color(0xFFF7F4F3);
  static const Color greenTone = Color(0xFF6bd425);
  static const Color errorColor = Color(0xFFE53935);
}

class Styles {
  Styles._();

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

  static const dateSaveText = TextStyle(
    color: Theming.bgColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const dateTextSelected = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Theming.primaryColor,
  );

  static const dateTextUnselected = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Theming.whiteTone,
  );

  static const partyHeaderTitle = TextStyle(
    color: Theming.whiteTone,
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  static const partyHeaderLocation = TextStyle(
    color: Theming.primaryColor,
    fontWeight: FontWeight.bold,
  );

  static const partyHeaderInfo = TextStyle(
    color: Theming.whiteTone,
    fontWeight: FontWeight.bold,
  );

  static final loginFormHintText = TextStyle(
    fontWeight: FontWeight.bold,
    color: Theming.whiteTone.withOpacity(0.7),
    fontSize: 16,
  );

  static const buttonText = TextStyle(
    fontWeight: FontWeight.bold,
    color: Theming.bgColor,
    fontSize: 18,
  );

  static const buttonTextLight = TextStyle(
    fontWeight: FontWeight.bold,
    color: Theming.whiteTone,
    fontSize: 18,
  );
}
