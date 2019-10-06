#!/bin/bash
echo "Rebuilding"
DART_FILES=$(find lib | grep '\.dart')
flutter packages pub run intl_translation:extract_to_arb --output-dir=lib/l10n $DART_FILES