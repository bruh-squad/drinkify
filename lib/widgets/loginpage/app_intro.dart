import 'package:flutter/material.dart';

import '/utils/theming.dart';

class AppIntro extends StatelessWidget {
  const AppIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Theming.bgColor,
    );
  }
}