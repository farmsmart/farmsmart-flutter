import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:farmsmart_flutter/l10n/messages_all.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Constants {
  static String defaultLocale = 'en_US';
}

class _Field {
  static String locale = 'locale';
}

class FarmsmartLocalizations {
  static Future<FarmsmartLocalizations> load() async {
    Locale locale = await getLocale();
    String localeName = _canonicalLocale(locale);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return FarmsmartLocalizations();
    });
  }

  static FarmsmartLocalizations of(BuildContext context) {
    return Localizations.of<FarmsmartLocalizations>(context, FarmsmartLocalizations);
  }

  static persistLocale(Locale locale) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_Field.locale, locale.languageCode);
  }

  static Future<Locale> getLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedLocale = prefs.get(_Field.locale);
    if(savedLocale != null){
      return Locale(savedLocale);
    }
    return Locale(_Constants.defaultLocale);
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
  Future<FarmsmartLocalizations> load(Locale locale) => FarmsmartLocalizations.load();

  @override
  bool shouldReload(FarmsmartLocalizationsDelegate old) => false;
}

String _canonicalLocale(Locale locale) {
  final String name = (locale.countryCode??"").isEmpty ? locale.languageCode : locale.toString();
  final String localeName = Intl.canonicalizedLocale(name);
  return localeName;
}