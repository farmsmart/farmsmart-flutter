// DART HAS NO DECIMAL NUMBER TYPE!!!!!!!!!
import 'package:decimal/decimal.dart';

class TransactionAmount {

  final Decimal _decimal;

  TransactionAmount._(this._decimal);

  factory TransactionAmount(String value, bool forceNegative) {
    final decimal = Decimal.parse(value);
    return TransactionAmount._(forceNegative ? -decimal : decimal);
  }

  String toString({bool allowNegative = false}) {
    //LH this is a transaction amount, which is never displayed as negative number.
    if(allowNegative) {
      return _decimal.toString();
    }
    return _decimal.isNegative ? (-_decimal).toString():_decimal.toString();
  }

  bool isSale() {
    return !isCost();
  }

  bool isCost() {
    return _decimal.isNegative;
  }

  TransactionAmount operator  +( covariant TransactionAmount other) => TransactionAmount._(_decimal + other._decimal);

}