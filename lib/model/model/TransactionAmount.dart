// DART HAS NO DECIMAL NUMBER TYPE!!!!!!!!!
import 'package:decimal/decimal.dart';

class TransactionAmount {

  final Decimal _decimal;

  TransactionAmount._(this._decimal);

  factory TransactionAmount(String value) {
    final decimal = Decimal.parse(value);
    return TransactionAmount._(decimal);
  }

  String toString() {
    return _decimal.toString();
  }

  bool isSale() {
    return !_decimal.isNegative;
  }

  bool isCost() {
    return _decimal.isNegative;
  }

}