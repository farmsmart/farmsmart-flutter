import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class FarmsmartLocalizations {
  static Future<FarmsmartLocalizations> load(Locale locale) {
    final String localeName = _canonicalLocale(locale);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      debugPrint('Loading locale ${Intl.defaultLocale}');
      return FarmsmartLocalizations();
    });
  }

  static FarmsmartLocalizations of(BuildContext context) {
    return Localizations.of<FarmsmartLocalizations>(context, FarmsmartLocalizations);
  }

  String get title => Intl.message("Farmsmart");

  String get shareArticleText => Intl.message("Check out this article from the FarmSmart mobile app \n ");

  String get errorString => Intl.message("Error");

  String get noTitleString => Intl.message("No Title");

  String get appDescription => Intl.message("Farmsmart Flutter App");

  String get appbarPopUpPolicies => Intl.message("Privacy Policies");

  String get myPlotTab => Intl.message("My Plot");

  String get profitLossTab => Intl.message("Profit/Loss");

  String get discoverTab => Intl.message("Discover");

  String get communityTab => Intl.message("Community");

  String get playgroundTab => Intl.message("Debug");

  String get myPlotCurrentStage => Intl.message("CURRENT STAGE");

  String get myPlotDetails => Intl.message("DETAILS");

  String get myPlotItemDefaultTitle => Intl.message("My Crop");

  String get myPlotDetailPropertiesTitle => Intl.message("Crop Details");

  String get myPlotDetailComplexityTitle => Intl.message("Complexity");

  String get myPlotDetailSoilTypeTitle => Intl.message("Best soil types");

  String get myPlotDetailMaturityLapseTitle => Intl.message("Time until maturity");

  String get myPlotDetailCropsToBeRotatedTitle => Intl.message("Crops in rotation");

  String get myPlotDetailCropTypeTitle => Intl.message("Crop type");

  String get myPlotDetailWaterRequirementTitle => Intl.message("Water requirement");

  String get myPlotDetailSetupCostTitle => Intl.message("Setup Cost");

  String get myPlotDetailProfitabilityTitle => Intl.message("Profitability");

  String get myPlotDetailCompanionPlantsTitle => Intl.message("Companion Plants");

  String get myPlotDetailNonCompanionPlantsTitle => Intl.message("Non-Companion Plants");

  String get myPlotDetailStepByStepTitle => Intl.message("Step-by-step guide");
}

class FarmsmartLocalizationsDelegate extends LocalizationsDelegate<FarmsmartLocalizations> {
  List<String> _languagesSupported;

  FarmsmartLocalizationsDelegate(List<Locale> locales) {
    _languagesSupported = locales.map((locale) => _canonicalLocale(locale)).toList();
  }

  @override
  bool isSupported(Locale locale) => _languagesSupported.contains(locale.languageCode);

  @override
  Future<FarmsmartLocalizations> load(Locale locale) => FarmsmartLocalizations.load(locale);

  @override
  bool shouldReload(FarmsmartLocalizationsDelegate old) => false;
}

String _canonicalLocale(Locale locale) {
  final String name = (locale.countryCode??"").isEmpty ? locale.languageCode : locale.toString();
  final String localeName = Intl.canonicalizedLocale(name);
  return localeName;
}