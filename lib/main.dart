import 'package:farmsmart_flutter/model/repositories/locale/locale_repository_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'app_coordinator.dart';
import 'farmsmart_localizations.dart';
import 'flavors/app_config.dart';
import 'model/repositories/image/ImageRepositoryInterface.dart';

class _Constants {
  static final String fontFamily = 'IBMPlexSans';

  static final backgroundColor = Color(0xFFFFFFFF);
  static final accentColor = Color(0xFF757575);
  static final defaultLocaleState = LocaleState(FarmsmartLocalizations.defaultLocale,
          [FarmsmartLocalizations.defaultLocale]);
}

class _String {
  static title() => 'FarmSmart';
}

class FarmSmartApp extends StatefulWidget {
  @override
  _FarmSmartAppState createState() => _FarmSmartAppState();
}


class _FarmSmartAppState extends State<FarmSmartApp> {
  @override
  Widget build(BuildContext context) {
    final repositoryProvider = AppConfig.of(context).repositoryProvider;
    repositoryProvider.init(context);
    return FutureBuilder<LocaleState>(
      future: repositoryProvider
            .getLocaleRepository()
            .getLocaleState()
            .then((state) {
          return startURLCache().then((_) {
            return state;
          });
        }),
      initialData: _Constants.defaultLocaleState,
      builder: (BuildContext context, AsyncSnapshot<LocaleState> snapshot) {
        final LocaleState state = snapshot.data ?? _Constants.defaultLocaleState;
        final supportedLocales =
            state.availableLocales.map<Locale>((e) => e.locale).toList();
        return MaterialApp(
          locale: state.currentLocale.locale,
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
