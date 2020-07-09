import 'dart:ui';

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
          .map<ContentLocale>((locale) =>ContentLocale( Locale(locale[_Constants.languageField],
              locale[_Constants.countryField]),locale[_Constants.displayNameField] ))
          .toList();
    });
  }
}
