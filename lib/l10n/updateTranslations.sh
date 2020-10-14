#!/bin/bash
echo "Updating"
cd ../../
DART_FILES=$(find lib | grep '\.dart')
flutter packages pub run intl_translation:generate_from_arb --output-dir=lib/l10n \
   --no-use-deferred-loading $DART_FILES lib/l10n/intl_*.arb
