import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_pl.dart';

class LocaleSupport {
  static AppLocalizations appTranslates() {
    String loadedLocale = "en";

    switch (loadedLocale) {
      case "en":
        return AppLocalizationsEn();
      case "pl":
        return AppLocalizationsPl();
      default:
        return AppLocalizationsEn();
    }
  }
}
