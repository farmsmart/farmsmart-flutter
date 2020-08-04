import 'package:farmsmart_flutter/model/bloc/ResetStateWidget.dart';
import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/locale/locale_selection_viewmodel.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class _Constants {
  static final Color enabledColor = Color(0xFF24d900);
  static final Color disabledColor = Color(0xFFe9eaf2);  
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

  Widget _buildSuccess(
      {BuildContext context,
      AsyncSnapshot<LocaleSelectionViewModel> snapshot}) {
    final viewmodel = snapshot.data;
    currentLocale = viewmodel.current;
    if (selectedLocale == null) {
      selectedLocale = currentLocale;
    }
    final selectedLanguage = selectedLocale.locale.languageCode;
    final selectedCountry = selectedLocale.locale.countryCode;

    final countries = viewmodel.items
        .map<String>((e) => e.locale.countryCode)
        .toSet()
        .toList();
    final countryOptions = countries
        .map((e) => ListTile(
              title: Text(e),
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
            element.locale.countryCode == selectedLocale.locale.countryCode)
        .toList();
    final lanuageOptions = languages
        .map((e) => ListTile(
              title: Text(e.locale.languageCode),
              onTap: () {
                setState(() {
                  selectedLocale = e;
                });
              },
            ))
        .toList();

    final selectedLanaguageTitle = 'Language - ' + selectedLanguage;
    final selectedCountryTitle = 'Country - ' + selectedCountry;
    final canSubmit = currentLocale.locale != selectedLocale.locale;
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(children: [
        Expanded(
            child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ExpansionTile(
              key: ValueKey(selectedCountryTitle),
              title: Text(selectedCountryTitle),
              children: countryOptions,
            ),
            ExpansionTile(
              key: ValueKey(selectedLanaguageTitle),
              title: Text(selectedLanaguageTitle),
              children: lanuageOptions,
            ),
          ],
        )),
        RoundedButton(
            viewModel: RoundedButtonViewModel(
                title: 'Submit',
                onTap: () {
                  Navigator.of(context).pop();
                  viewmodel.selectLocale(selectedLocale);
                  ResetStateWidget.resetState(context);
                }),
            style: canSubmit ? RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
                backgroundColor: _Constants.enabledColor,
              )
            : RoundedButtonStyle.largeRoundedButtonStyle().copyWith(
                backgroundColor: _Constants.disabledColor,
              )),
      ]),
    );
  }
}
