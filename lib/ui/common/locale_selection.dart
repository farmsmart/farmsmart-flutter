import 'package:country_codes/country_codes.dart';
import 'package:farmsmart_flutter/model/bloc/ResetStateWidget.dart';
import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/locale/locale_selection_viewmodel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../country_flags.dart';

class _Constants {
  static final Color enabledColor = Color(0xFF24d900);
  static final Color disabledColor = Color(0xFFe9eaf2);
  static final textStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 17,
  );
}

class _LocalisedStrings {
  static String country() => Intl.message('Country');
  static String lanugage() => Intl.message('Language');
  static String apply() => Intl.message('Apply');
}

class LocaleSelection extends StatefulWidget {
  static present(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (widgetBuilder) => LocaleSelection());
  }

  @override
  _LocaleSelectionState createState() => _LocaleSelectionState();
}

class _LocaleSelectionState extends State<LocaleSelection> {
  LocaleItemViewModel currentLocale;
  LocaleItemViewModel selectedLocale;

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ViewModelProvider<LocaleSelectionViewModel>>(context);
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(40),
          topRight: const Radius.circular(40),
        ),
        child: Container(
            decoration: BoxDecoration(color: const Color(0xFFffffff)),
            child: ViewModelProviderBuilder<LocaleSelectionViewModel>(
              provider: provider,
              successBuilder: _buildSuccess,
            )));
  }

  String _countryDisplayName(Locale locale) {
    final localeDetails = CountryCodes.detailsForLocale(locale);
    return getEmojiFlag(locale.countryCode) + ' ' + localeDetails.name;
  }

  Widget _buildSuccess(
      {BuildContext context,
      AsyncSnapshot<LocaleSelectionViewModel> snapshot}) {
    final viewmodel = snapshot.data;
    currentLocale = viewmodel.current;
    if (selectedLocale == null) {
      selectedLocale = currentLocale;
    }
    final selectedLanguage = selectedLocale.title;
    final selectedCountry = _countryDisplayName(selectedLocale.locale);

    final countries = viewmodel.items
        .map<String>((e) => e.locale.countryCode)
        .toSet()
        .toList();

    final countryOptions = countries
        .map((e) => ListTile(
              title: Text(
                _countryDisplayName(Locale('en', e)),
                style: _Constants.textStyle,
              ),
              onTap: () {
                setState(() {
                  selectedLocale = viewmodel.items
                      .firstWhere((element) => element.locale.countryCode == e);
                });
              },
            ))
        .toList();
    final languages = viewmodel.items
        .where((element) =>
            (element.locale.countryCode == selectedLocale.locale.countryCode) &&
            element.locale.languageCode != selectedLocale.locale.languageCode)
        .toList();
    final lanuageOptions = languages
        .map((e) => ListTile(
              title: Text(e.title, style: _Constants.textStyle),
              onTap: () {
                setState(() {
                  selectedLocale = e;
                });
              },
            ))
        .toList();

    final canSubmit = currentLocale.locale != selectedLocale.locale;

    final languageTile = lanuageOptions.isNotEmpty
        ? ExpansionTile(
            key: ValueKey(selectedLanguage),
            leading:
                Text(_LocalisedStrings.lanugage(), style: _Constants.textStyle),
            title: Text(selectedLanguage, style: _Constants.textStyle),
            children: lanuageOptions,
          )
        : ListTile(
            leading:
                Text(_LocalisedStrings.lanugage(), style: _Constants.textStyle),
            title: Text(selectedLanguage, style: _Constants.textStyle));
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(children: [
        Expanded(
            child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ExpansionTile(
              key: ValueKey(selectedCountry),
              leading: Text(_LocalisedStrings.country(),
                  style: _Constants.textStyle),
              title: Text(selectedCountry, style: _Constants.textStyle),
              children: countryOptions,
            ),
            languageTile,
          ],
        )),
        RoundedButton(

            viewModel: RoundedButtonViewModel(
                title: _LocalisedStrings.apply(),
                onTap: () {
                  if(canSubmit) {
                    Navigator.of(context).pop();
                    viewmodel.selectLocale(selectedLocale);
                    ResetStateWidget.resetState(context);
                  }
                }),
            style: canSubmit
                ? RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
                    backgroundColor: _Constants.enabledColor,
                  )
                : RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
                    backgroundColor: _Constants.disabledColor,
                  )),
      ]),
    );
  }
}
