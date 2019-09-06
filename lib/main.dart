import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_coordinator.dart';
import 'farmsmart_localizations.dart';

class _Constants {
  static final String fontFamily = 'GT-America-Standard';

  static final backgroundColor = Color(0xFFFFFFFF);
  static final accentColor = Color(0xFF757575);

  static final List<Locale> supportedLocales = [
    const Locale('en'),
    const Locale('sw'),
  ];
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
    return FutureBuilder<Locale>(
      future: FarmsmartLocalizations.getLocale(),
      initialData: _Constants.supportedLocales.first,
      builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
        return MaterialApp(
          locale: snapshot.data,
          onGenerateTitle: (context) => _String.title(),
          localizationsDelegates: [
            FarmsmartLocalizationsDelegate(_Constants.supportedLocales),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: _Constants.supportedLocales,
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
