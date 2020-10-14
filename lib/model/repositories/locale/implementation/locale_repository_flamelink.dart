import 'dart:ui';

import 'package:farmsmart_flutter/farmsmart_localizations.dart';

import '../../FlameLink.dart';
import '../locale_repository_interface.dart';

class _Constants {
  static const globalSettingsSchema = 'globalSettings';
  static const supportedLocales = 'supportedLocales';
  static const languageField = 'languageCode';
  static const countryField = 'countryCode';
  static const displayNameField = 'displayName';
}

class LocaleRepositoryFlameLink implements LocaleRepositoryInterface {
  final FlameLink _cms;

  LocaleRepositoryFlameLink(FlameLink cms) : _cms = cms;

  @override
  Future<List<ContentLocale>> availableLocales() {
    return _cms
        .getSingle(schema: _Constants.globalSettingsSchema)
        .then((snapshot) {
      final supportedLocales = snapshot.data[_Constants.supportedLocales];
      return supportedLocales
          .map<ContentLocale>((locale) => ContentLocale(
              Locale(locale[_Constants.languageField],
                  locale[_Constants.countryField]),
              locale[_Constants.displayNameField]))
          .toList();
    });
  }

  @override
  Future<ContentLocale> currentLocale() {
    return availableLocales().then((availableLocales) {
      return FarmsmartLocalizations.getLocale().then((locale) {
        return availableLocales.firstWhere(
            (element) => element.locale == locale,
            orElse: () => FarmsmartLocalizations.defaultLocale);
      });
    });
  }

  @override
  Future<LocaleState> getLocaleState() {
    return availableLocales().then((availableLocales) {
      return FarmsmartLocalizations.getLocale().then((locale) {
        final currentLocale = availableLocales.firstWhere(
            (element) => element.locale == locale,
            orElse: () => FarmsmartLocalizations.defaultLocale);
        return LocaleState(currentLocale, availableLocales);
      });
    });
  }
}
