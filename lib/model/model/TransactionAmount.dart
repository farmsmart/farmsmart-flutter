// DART HAS NO DECIMAL NUMBER TYPE!!!!!!!!!
import 'package:decimal/decimal.dart';

class TransactionAmount {

  final Decimal _decimal;

  TransactionAmount._(this._decimal);

  factory TransactionAmount(String value, bool forceNegative) {
    final decimal = Decimal.parse(value);
    return TransactionAmount._(forceNegative ? -decimal : decimal);
  }

  String toString() {
    return _decimal.toString();
  }

  bool isSale() {
    return !isCost();
  }

  bool isCost() {
    return _decimal.isNegative;
  }

  TransactionAmount operator  +( covariant TransactionAmount other) => TransactionAmount._(_decimal + other._decimal);

}