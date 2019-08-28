// DART HAS NO DECIMAL NUMBER TYPE!!!!!!!!!
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class _Strings {
  static const negativeSymbol = "-";
}

class TransactionAmount {
  final Decimal _decimal;

  TransactionAmount._(this._decimal);

  factory TransactionAmount(String value, bool forceNegative) {
    final decimal = Decimal.parse(value);
    return TransactionAmount._(forceNegative ? -decimal : decimal);
  }

  String toString({bool allowNegative = false}) {
    final formatter =
        NumberFormat.compactCurrency(locale: Intl.getCurrentLocale());
    final absDecimal = _decimal.isNegative ? -_decimal : _decimal;
    final prefix =
        (_decimal.isNegative && allowNegative) ? _Strings.negativeSymbol : "";
    return prefix +
        formatter
            .format(absDecimal.toDouble())
            .replaceAll(formatter.currencyName, "");
  }

  bool isSale() {
    return !isCost();
  }

  bool isCost() {
    return _decimal.isNegative;
  }

  TransactionAmount operator +(covariant TransactionAmount other) =>
      TransactionAmount._(_decimal + other._decimal);
}
