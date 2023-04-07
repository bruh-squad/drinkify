import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './utils/router.dart';
import './utils/theming.dart';

void main() async {
  runApp(const App());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Theming.bgColor.withOpacity(0.002),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Theming.bgColor.withOpacity(0.002),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
    overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ],
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: ".env");
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        title: "Drinkify",
        theme: ThemeData(
          fontFamily: 'Nunito',
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
  }
}
