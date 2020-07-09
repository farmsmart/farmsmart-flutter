import 'dart:ui';

class ContentLocale {
  final Locale locale;
  final String displayName;

  ContentLocale(this.locale, this.displayName);
}

class LocaleState {
  final ContentLocale currentLocale;
  final List<ContentLocale> availableLocales;
  LocaleState(this.currentLocale, this.availableLocales);
}

abstract class LocaleRepositoryInterface {
  Future<List<ContentLocale>> availableLocales();
  Future<ContentLocale> currentLocale();
  Future<LocaleState> getLocaleState();
}