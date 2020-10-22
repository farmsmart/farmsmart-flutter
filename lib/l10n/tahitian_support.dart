import 'dart:async';

import 'package:intl/intl.dart' as intl;
import 'package:intl/date_symbol_data_local.dart' as intl;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:intl/date_symbol_data_local.dart' as hack;
import 'package:intl/date_time_patterns.dart' as hack;
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart' as hack;
import 'package:intl/date_symbols.dart';
// ignore: implementation_imports
import "package:intl/src/date_format_internal.dart" as dfi;

//WARNING: This file is a quick work around to support tahitain, it does not translate all needed for full support, only the elements the app uses.

class _TyMaterialLocalizationsDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _TyMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ty';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    final String localeName = intl.Intl.canonicalizedLocale(locale.toString());
    await intl.initializeDateFormatting(localeName, null);

    Map sdMap = Map.from(hack.dateTimeSymbolMap());
    Map tpMap = Map.from(hack.dateTimePatternMap());

    //Big HACK --- injecting the lookup for ty (tahitian) language
    //instead of calling initializeDateFormatting(localeName, null) we call directly to date_format_internal.dart
    sdMap["ty"] = tyDateSymbols;

    dfi.dateTimeSymbols = sdMap;

    tpMap["ty"] = tyDateTimePatterns;

    dfi.dateTimePatterns = tpMap;

    hack.numberFormatSymbols["ty"] = tyNumberSymbols;

    return SynchronousFuture<MaterialLocalizations>(
      TyMaterialLocalizations(
        localeName: localeName,
        fullYearFormat: intl.DateFormat('y', localeName),
        compactDateFormat: intl.DateFormat('yMd', localeName),
        shortDateFormat: intl.DateFormat('yMMMd', localeName),
        mediumDateFormat: intl.DateFormat('EEE, MMM d', localeName),
        longDateFormat: intl.DateFormat('EEEE, MMMM d, y', localeName),
        yearMonthFormat: intl.DateFormat('MMMM y', localeName),
        shortMonthDayFormat: intl.DateFormat('MMM d', localeName),
        decimalFormat: intl.NumberFormat('#,##0.###', localeName),
        twoDigitZeroPaddedFormat: intl.NumberFormat('00', localeName),
      ),
    );
  }

  @override
  bool shouldReload(_TyMaterialLocalizationsDelegate old) => false;
}

class TyMaterialLocalizations extends GlobalMaterialLocalizations {
  const TyMaterialLocalizations({
    String localeName = 'ty',
    @required intl.DateFormat fullYearFormat,
    @required intl.DateFormat compactDateFormat,
    @required intl.DateFormat shortDateFormat,
    @required intl.DateFormat mediumDateFormat,
    @required intl.DateFormat longDateFormat,
    @required intl.DateFormat yearMonthFormat,
    @required intl.DateFormat shortMonthDayFormat,
    @required intl.NumberFormat decimalFormat,
    @required intl.NumberFormat twoDigitZeroPaddedFormat,
  }) : super(
          localeName: localeName,
          fullYearFormat: fullYearFormat,
          compactDateFormat: compactDateFormat,
          shortDateFormat: shortDateFormat,
          mediumDateFormat: mediumDateFormat,
          longDateFormat: longDateFormat,
          yearMonthFormat: yearMonthFormat,
          shortMonthDayFormat: shortMonthDayFormat,
          decimalFormat: decimalFormat,
          twoDigitZeroPaddedFormat: twoDigitZeroPaddedFormat,
        );

  @override
  String get moreButtonTooltip => r'More';

  @override
  String get aboutListTileTitleRaw => r'About $applicationName';

  @override
  String get alertDialogLabel => r'Alert';

  @override
  String get anteMeridiemAbbreviation => r'AM';

  @override
  String get backButtonTooltip => r'Back';

  @override
  String get cancelButtonLabel => 'FAA\'ORE';

  @override
  String get closeButtonLabel => r'CLOSE';

  @override
  String get closeButtonTooltip => r'Close';

  @override
  String get collapsedIconTapHint => r'Expand';

  @override
  String get continueButtonLabel => r'CONTINUE';

  @override
  String get copyButtonLabel => r'COPY';

  @override
  String get cutButtonLabel => r'CUT';

  @override
  String get deleteButtonTooltip => r'Delete';

  @override
  String get dialogLabel => r'Dialog';

  @override
  String get drawerLabel => r'Navigation menu';

  @override
  String get expandedIconTapHint => r'Collapse';

  @override
  String get hideAccountsLabel => r'Hide accounts';

  @override
  String get licensesPageTitle => r'Licenses';

  @override
  String get modalBarrierDismissLabel => r'Dismiss';

  @override
  String get nextMonthTooltip => r'Next month';

  @override
  String get nextPageTooltip => r'Next page';

  @override
  String get okButtonLabel => r'OK';

  @override
  String get openAppDrawerTooltip => r'Open navigation menu';

  @override
  String get pageRowsInfoTitleRaw => r'$firstRow–$lastRow of $rowCount';

  @override
  String get pageRowsInfoTitleApproximateRaw =>
      r'$firstRow–$lastRow of about $rowCount';

  @override
  String get pasteButtonLabel => r'PASTE';

  @override
  String get popupMenuLabel => r'Popup menu';

  @override
  String get postMeridiemAbbreviation => r'PM';

  @override
  String get previousMonthTooltip => r'Previous month';

  @override
  String get previousPageTooltip => r'Previous page';

  @override
  String get refreshIndicatorSemanticLabel => r'Refresh';

  @override
  String get remainingTextFieldCharacterCountFew => null;

  @override
  String get remainingTextFieldCharacterCountMany => null;

  @override
  String get remainingTextFieldCharacterCountOne => r'1 character remaining';

  @override
  String get remainingTextFieldCharacterCountOther =>
      r'$remainingCount characters remaining';

  @override
  String get remainingTextFieldCharacterCountTwo => null;

  @override
  String get remainingTextFieldCharacterCountZero => r'No characters remaining';

  @override
  String get reorderItemDown => r'Move down';

  @override
  String get reorderItemLeft => r'Move left';

  @override
  String get reorderItemRight => r'Move right';

  @override
  String get reorderItemToEnd => r'Move to the end';

  @override
  String get reorderItemToStart => r'Move to the start';

  @override
  String get reorderItemUp => r'Move up';

  @override
  String get rowsPerPageTitle => r'Rows per page:';

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get searchFieldLabel => r'Search';

  @override
  String get selectAllButtonLabel => r'SELECT ALL';

  @override
  String get selectedRowCountTitleFew => null;

  @override
  String get selectedRowCountTitleMany => null;

  @override
  String get selectedRowCountTitleOne => r'1 item selected';

  @override
  String get selectedRowCountTitleOther => r'$selectedRowCount items selected';

  @override
  String get selectedRowCountTitleTwo => null;

  @override
  String get selectedRowCountTitleZero => r'No items selected';

  @override
  String get showAccountsLabel => r'Show accounts';

  @override
  String get showMenuTooltip => r'Show menu';

  @override
  String get signedInLabel => r'Signed in';

  @override
  String get tabLabelRaw => r'Tab $tabIndex of $tabCount';

  @override
  TimeOfDayFormat get timeOfDayFormatRaw => TimeOfDayFormat.h_colon_mm_space_a;

  @override
  String get timePickerHourModeAnnouncement => r'Select hours';

  @override
  String get timePickerMinuteModeAnnouncement => r'Select minutes';

  @override
  String get viewLicensesButtonLabel => r'VIEW LICENSES';

  @override
  List<String> get narrowWeekdays =>
      const <String>['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  int get firstDayOfWeekIndex => 0;

  static const LocalizationsDelegate<MaterialLocalizations> delegate =
      _TyMaterialLocalizationsDelegate();

  @override
  String get calendarModeButtonLabel => r'Switch to calendar';

  @override
  String get dateHelpText => r'mm/dd/yyyy';

  @override
  String get dateInputLabel => r'Enter Date';

  @override
  String get dateOutOfRangeLabel => r'Out of range.';

  @override
  String get datePickerHelpText => r'Te mahana';

  @override
  String get dateRangeEndDateSemanticLabelRaw => r'End date $fullDate';

  @override
  String get dateRangeEndLabel => r'End Date';

  @override
  String get dateRangePickerHelpText => 'SELECT RANGE';

  @override
  String get dateRangeStartDateSemanticLabelRaw => 'Start date \$fullDate';

  @override
  String get dateRangeStartLabel => 'Start Date';

  @override
  String get dateSeparator => '/';

  @override
  String get dialModeButtonLabel => 'Switch to dial picker mode';

  @override
  String get inputDateModeButtonLabel => 'Switch to input';

  @override
  String get inputTimeModeButtonLabel => 'Switch to text input mode';

  @override
  String get invalidDateFormatLabel => 'Invalid format.';

  @override
  String get invalidDateRangeLabel => 'Invalid range.';

  @override
  String get invalidTimeLabel => 'Enter a valid time';

  @override
  String get licensesPackageDetailTextOther => '\$licenseCount licenses';

  @override
  String get saveButtonLabel => 'SAVE';

  @override
  String get selectYearSemanticsLabel => 'Select year';

  @override
  String get timePickerDialHelpText => 'SELECT TIME';

  @override
  String get timePickerHourLabel => 'Hour';

  @override
  String get timePickerInputHelpText => 'ENTER TIME';

  @override
  String get timePickerMinuteLabel => 'Minute';

  @override
  String get unspecifiedDate => 'Date';

  @override
  String get unspecifiedDateRange => 'Date Range';
}

final tyDateSymbols = DateSymbols(
    NAME: "ty",
    ERAS: const ['BC', 'AD'],
    ERANAMES: const ['Before Christ', 'Anno Domini'],
    NARROWMONTHS: const [
      'T',
      'F',
      'M',
      'E',
      'ME',
      'Tu',
      'Ti',
      'A',
      'Te',
      'A',
      'N',
      'Ta'
    ],
    STANDALONENARROWMONTHS: const [
      'T',
      'F',
      'M',
      'E',
      'ME',
      'Tu',
      'Ti',
      'A',
      'Te',
      'A',
      'N',
      'Ta'
    ],
    MONTHS: const [
      'Tenuare',
      'Fepuare',
      'Māti',
      'Eperera',
      'Me',
      'Tiunu',
      'Tiurai',
      'Ātete',
      'Tetepa',
      'Atopa',
      'Novema',
      'Titema'
    ],
    STANDALONEMONTHS: const [
      'Tenuare',
      'Fepuare',
      'Māti',
      'Eperera',
      'Me',
      'Tiunu',
      'Tiurai',
      'Ātete',
      'Tetepa',
      'Atopa',
      'Novema',
      'Titema'
    ],
    SHORTMONTHS: const [
      'Tenua.',
      'Fepua.',
      'Mati.',
      'Epere.',
      'Me.',
      'Tiunu.',
      'Tiurai.',
      'Atete.',
      'Tete.',
      'Ato.',
      'Nove.',
      'Tite.'
    ],
    STANDALONESHORTMONTHS: const [
      'Tenua',
      'Fepua',
      'Mati',
      'Epere',
      'Me',
      'Tiunu',
      'Tiurai',
      'Atete',
      'Tete',
      'Ato',
      'Nove',
      'Tite'
    ],
    WEEKDAYS: const [
      'monire',
      'mahana piti',
      'mahana toru',
      'mahana maha',
      'mahana pae',
      'mahana mā\'a',
      'tāpati'
    ],
    STANDALONEWEEKDAYS: const [
      'monire',
      'mahana piti',
      'mahana toru',
      'mahana maha',
      'mahana pae',
      'mahana mā\'a',
      'tāpati'
    ],
    SHORTWEEKDAYS: const [
      'mon',
      'maha 2',
      'maha 3',
      'maha 4',
      'maha 5',
      'maha mā\'a',
      'tāpati'
    ],
    STANDALONESHORTWEEKDAYS: const [
      'mon',
      'maha 2',
      'maha 3',
      'maha 4',
      'maha 5',
      'maha mā\'a',
      'tāpati'
    ],
    NARROWWEEKDAYS: const ['M', '2', '3', '4', '5', 'mā', 'T'],
    STANDALONENARROWWEEKDAYS: const ['M', '2', '3', '4', '5', 'mā', 'T'],
    SHORTQUARTERS: const ['Q1', 'Q2', 'Q3', 'Q4'],
    QUARTERS: const ['1. Quarter', '2. Quarter', '3. Quarter', '4. Quarter'],
    AMPMS: const ['a.m.', 'p.m.'],
    DATEFORMATS: const ['EEEE d. MMMM y', 'd. MMMM y', 'd. MMM y', 'dd.MM.y'],
    TIMEFORMATS: const ['HH:mm:ss zzzz', 'HH:mm:ss z', 'HH:mm:ss', 'HH:mm'],
    DATETIMEFORMATS: const [
      '{1} {0}',
      '{1} \'kl\'. {0}',
      '{1}, {0}',
      '{1}, {0}'
    ],
    FIRSTDAYOFWEEK: 0,
    WEEKENDRANGE: const [5, 6],
    FIRSTWEEKCUTOFFDAY: 3);

/// Extended set of localized date/time patterns for locale ty
const tyDateTimePatterns = {
  'd': 'd.', // DAY
  'E': 'ccc', // ABBR_WEEKDAY
  'EEEE': 'cccc', // WEEKDAY
  'LLL': 'LLL', // ABBR_STANDALONE_MONTH
  'LLLL': 'LLLL', // STANDALONE_MONTH
  'M': 'L.', // NUM_MONTH
  'Md': 'd.M.', // NUM_MONTH_DAY
  'MEd': 'EEE d.M.', // NUM_MONTH_WEEKDAY_DAY
  'MMM': 'LLL', // ABBR_MONTH
  'MMMd': 'd. MMM', // ABBR_MONTH_DAY
  'MMMEd': 'EEE d. MMM', // ABBR_MONTH_WEEKDAY_DAY
  'MMMM': 'LLLL', // MONTH
  'MMMMd': 'd. MMMM', // MONTH_DAY
  'MMMMEEEEd': 'EEEE d. MMMM', // MONTH_WEEKDAY_DAY
  'QQQ': 'QQQ', // ABBR_QUARTER
  'QQQQ': 'QQQQ', // QUARTER
  'y': 'y', // YEAR
  'yM': 'M.y', // YEAR_NUM_MONTH
  'yMd': 'd.M.y', // YEAR_NUM_MONTH_DAY
  'yMEd': 'EEE d.MM.y', // YEAR_NUM_MONTH_WEEKDAY_DAY
  'yMMM': 'MMM y', // YEAR_ABBR_MONTH
  'yMMMd': 'd. MMM y', // YEAR_ABBR_MONTH_DAY
  'yMMMEd': 'EEE d. MMM y', // YEAR_ABBR_MONTH_WEEKDAY_DAY
  'yMMMM': 'MMMM y', // YEAR_MONTH
  'yMMMMd': 'd. MMMM y', // YEAR_MONTH_DAY
  'yMMMMEEEEd': 'EEEE d. MMMM y', // YEAR_MONTH_WEEKDAY_DAY
  'yQQQ': 'QQQ y', // YEAR_ABBR_QUARTER
  'yQQQQ': 'QQQQ y', // YEAR_QUARTER
  'H': 'HH', // HOUR24
  'Hm': 'HH:mm', // HOUR24_MINUTE
  'Hms': 'HH:mm:ss', // HOUR24_MINUTE_SECOND
  'j': 'HH', // HOUR
  'jm': 'HH:mm', // HOUR_MINUTE
  'jms': 'HH:mm:ss', // HOUR_MINUTE_SECOND
  'jmv': 'HH:mm v', // HOUR_MINUTE_GENERIC_TZ
  'jmz': 'HH:mm z', // HOUR_MINUTETZ
  'jz': 'HH z', // HOURGENERIC_TZ
  'm': 'm', // MINUTE
  'ms': 'mm:ss', // MINUTE_SECOND
  's': 's', // SECOND
  'v': 'v', // ABBR_GENERIC_TZ
  'z': 'z', // ABBR_SPECIFIC_TZ
  'zzzz': 'zzzz', // SPECIFIC_TZ
  'ZZZZ': 'ZZZZ' // ABBR_UTC_TZ
};

const tyNumberSymbols = NumberSymbols(
    NAME: "ty",
    DECIMAL_SEP: ',',
    GROUP_SEP: '\u00A0',
    PERCENT: '%',
    ZERO_DIGIT: '0',
    PLUS_SIGN: '+',
    MINUS_SIGN: '\u2212',
    EXP_SYMBOL: 'E',
    PERMILL: '\u2030',
    INFINITY: '\u221E',
    NAN: 'NaN',
    DECIMAL_PATTERN: '#.##0,###',
    SCIENTIFIC_PATTERN: '#E0',
    PERCENT_PATTERN: '#,##0\u00A0%',
    CURRENCY_PATTERN: '\u00A4\u00A0#,##0.00',
    DEF_CURRENCY_CODE: 'XPF');
