import 'package:flutter/material.dart';

class Theming {
  Theming._();

  static const Color primaryColor = Color(0xFF0EB1D2);
  static const Color bgColorLight = Color(0xFF004497);
  static const Color bgColor = Color(0xFF011936);
  static const Color whiteTone = Color(0xFFF7F4F3);
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
      fontWeight: FontWeight.bold);

  static const hintTextSearchBar = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
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
    fontSize: 20,
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

  static const appBarTitle = TextStyle(
    color: Theming.whiteTone,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final userInfoType = TextStyle(
    color: Theming.whiteTone.withOpacity(0.5),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const userInfoStatistic = TextStyle(
    color: Theming.whiteTone,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}
