import 'package:country_codes/country_codes.dart';
import 'package:farmsmart_flutter/model/repositories/locale/locale_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:farmsmart_flutter/l10n/messages_all.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/analytics_interface.dart';

class _AnalyticsNames {
  static const switchLocale = 'locale_changed';
  static const localeParameter = 'locale';
}

class _Field {
  static String locale = 'locale';
  static String country = 'country';
}

class FarmsmartLocalizations {
  static final defaultLocale = ContentLocale( Locale('en','KE'),'English (Kenya)');
  static Future<FarmsmartLocalizations> load() async {
    Locale locale = await getLocale();
    String localeName = _canonicalLocale(locale);
    AnalyticsInterface.implementation().userProperty(_AnalyticsNames.localeParameter, locale.toString());
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
    prefs.setString(_Field.country, locale.countryCode);
    final stringLocale = locale.toString();
    AnalyticsInterface.implementation().effect(_AnalyticsNames.switchLocale, parameters:{_AnalyticsNames.localeParameter :stringLocale});
  }

  static Future<bool> hasPersistedLocale() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.get(_Field.locale) !=null;
  }

  static Future<Locale> getLocale() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedLocale = prefs.get(_Field.locale);
    String savedCountry= prefs.get(_Field.country);
    if(savedLocale != null){
      return Locale(savedLocale,savedCountry);
    }
    return CountryCodes.getDeviceLocale();
  }

}

class FarmsmartLocalizationsDelegate extends LocalizationsDelegate<FarmsmartLocalizations> {
  List<String> _languagesSupported;

  FarmsmartLocalizationsDelegate(List<Locale> locales) {
    _languagesSupported = locales.map((locale) => _canonicalLocale(locale)).toList();
  }

  @override
  bool isSupported(Locale locale) => _languagesSupported.contains(_canonicalLocale(locale));

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

class MaterialLocalizationTy extends MaterialLocalizationEn {
  
}