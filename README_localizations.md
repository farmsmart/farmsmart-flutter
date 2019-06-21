
# Farmsmart localizations uses dart intl package

## 1. Extract the intl strings into messages.arb using command

```
flutter packages pub run intl_translation:extract_to_arb --output-dir=assets/l10n lib/farmsmart_localizations.dart
```

## 2. Upload assets/l10n/messages_all.arb to [Google Translate Toolkit](https://translate.google.com/toolkit/) to manage translations, select the supported languages.
## 3. Once completed rename all languages versions to intl_<locale>.arb
## 4. Download and copy all *.arb files into folder: assets/l10n/

## 5. generate dart for each locale

```
flutter packages pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/farmsmart_localizations.dart assets/l10n/intl_*.arb
```

## 6. Add localized string getters in farmsmart_localizations.dart

## 7. To use localizations from single source 
```
    FarmsmartLocalizations.of(context).title
```