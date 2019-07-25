import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_coordinator.dart';
import 'farmsmart_localizations.dart';

void main() => runApp(FarmSmartApp());

class _Constants {
  static final String fontFamily = 'GT-America-Standard';

  static final backgroundColor = Color(0xFFFFFFFF);
  static final primaryGrey = Color(0xFF757575);

  static final List<Locale> supportedLocales = [
    const Locale('en'),
    const Locale('sw'),
  ];
}

class FarmSmartApp extends StatefulWidget {
  @override
  _FarmSmartAppState createState() => _FarmSmartAppState();
}

class _FarmSmartAppState extends State<FarmSmartApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => FarmsmartLocalizations.of(context).title,
      localizationsDelegates: [
        // ... app specific localization delegates here
        FarmsmartLocalizationsDelegate(_Constants.supportedLocales),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: _Constants.supportedLocales,
      theme: ThemeData(
        fontFamily: _Constants.fontFamily,
        brightness: Brightness.light,
        scaffoldBackgroundColor: _Constants.backgroundColor,
        primaryColor: _Constants.backgroundColor,
        accentColor: _Constants.primaryGrey,
      ),
      home: AppCoordinator(),
    );
  }
}
