import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:farmsmart_flutter/l10n/messages_all.dart';

class FarmsmartLocalizations {
  static Future<FarmsmartLocalizations> load(Locale locale) {
    final String localeName = _canonicalLocale(locale);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      debugPrint('Loading locale ${Intl.defaultLocale}');
      return FarmsmartLocalizations();
    });
  }

  static FarmsmartLocalizations of(BuildContext context) {
    return Localizations.of<FarmsmartLocalizations>(context, FarmsmartLocalizations);
  }

}

class FarmsmartLocalizationsDelegate extends LocalizationsDelegate<FarmsmartLocalizations> {
  List<String> _languagesSupported;

  FarmsmartLocalizationsDelegate(List<Locale> locales) {
    _languagesSupported = locales.map((locale) => _canonicalLocale(locale)).toList();
  }

  @override
  bool isSupported(Locale locale) => _languagesSupported.contains(locale.languageCode);

  @override
  Future<FarmsmartLocalizations> load(Locale locale) => FarmsmartLocalizations.load(locale);

  @override
  bool shouldReload(FarmsmartLocalizationsDelegate old) => false;
}

String _canonicalLocale(Locale locale) {
  final String name = (locale.countryCode??"").isEmpty ? locale.languageCode : locale.toString();
  final String localeName = Intl.canonicalizedLocale(name);
  return localeName;
}