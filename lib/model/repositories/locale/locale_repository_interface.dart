import 'dart:ui';

class ContentLocale {
  final Locale locale;
  final String displayName;

  ContentLocale(this.locale, this.displayName);
}
abstract class LocaleRepositoryInterface {
  Future<List<ContentLocale>> availableLocales();
}