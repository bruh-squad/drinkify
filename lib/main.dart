import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './utils/router.dart';
import './utils/theming.dart';

void main() {
  runApp(const App());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Theming.bgColor.withOpacity(0.002),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Theming.bgColor,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [SystemUiOverlay.top],
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        title: "Alkoholicy",
        theme: ThemeData(
          fontFamily: 'Nunito',
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
