import 'package:farmsmart_flutter/model/repositories/locale/locale_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'app_coordinator.dart';
import 'farmsmart_localizations.dart';
import 'flavors/app_config.dart';
import 'model/repositories/image/ImageRepositoryInterface.dart';

class _Constants {
  static final String fontFamily = 'IBMPlexSans';

  static final backgroundColor = Color(0xFFFFFFFF);
  static final accentColor = Color(0xFF757575);
}

class _String {
  static title() => 'FarmSmart';
}

class FarmSmartApp extends StatefulWidget {
  @override
  _FarmSmartAppState createState() => _FarmSmartAppState();
}

class _LocaleSettings {
  final ContentLocale currentLocale;
  final List<ContentLocale> supportedLocales;

  _LocaleSettings(this.currentLocale, this.supportedLocales);
}

class _FarmSmartAppState extends State<FarmSmartApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_LocaleSettings>(
      future: FarmsmartLocalizations.getLocale().then((locale) {
        final repositoryProvider = AppConfig.of(context).repositoryProvider;
        return repositoryProvider
            .getLocaleRepository()
            .availableLocales()
            .then((availableLocales) {
          final matchingLocale = availableLocales.firstWhere(
              (element) => element.locale == locale,
              orElse: () => FarmsmartLocalizations.defaultLocale);
          return startURLCache().then((_) {
            return _LocaleSettings(matchingLocale, availableLocales);
          });
        });
      }),
      initialData: _LocaleSettings(FarmsmartLocalizations.defaultLocale,
          [FarmsmartLocalizations.defaultLocale]),
      builder: (BuildContext context, AsyncSnapshot<_LocaleSettings> snapshot) {
        final _LocaleSettings settings = snapshot.data;
        final supportedLocales =
            settings.supportedLocales.map<Locale>((e) => e.locale).toList();
        return MaterialApp(
          locale: settings.currentLocale.locale,
          onGenerateTitle: (context) => _String.title(),
          localizationsDelegates: [
            FarmsmartLocalizationsDelegate(supportedLocales),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: supportedLocales,
          theme: ThemeData(
            fontFamily: _Constants.fontFamily,
            brightness: Brightness.light,
            scaffoldBackgroundColor: _Constants.backgroundColor,
            primaryColor: _Constants.backgroundColor,
            accentColor: _Constants.accentColor,
          ),
          home: AppCoordinator(),
        );
      },
    );
  }
}
