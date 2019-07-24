import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionHeader.dart';
import 'package:flutter/material.dart';

class RecordTransactionHeaderStyles {
  static RecordTransactionHeaderStyle _defaultStyle = RecordTransactionHeaderStyle(
    hintTextStyle: TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.w500,
      color: Color(0x4c24d900),
      letterSpacing: 4.32,
    ),
    titleTextStyle: TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.w500,
      color: Color(0xFF24d900),
      letterSpacing: 4.32,
    ),
    edgePadding: EdgeInsets.symmetric(horizontal: 32),
    height: 137.5,
    maxLines: 1,
  );

  static RecordTransactionHeaderStyle defaultSaleStyle = _defaultStyle.copyWith();

  static RecordTransactionHeaderStyle defaultCostStyle = _defaultStyle.copyWith(
    hintTextStyle: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.w500,
      color: Color(0x4cff8d4f),
      letterSpacing: 4.32,
    ),
    titleTextStyle: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.w500,
      color: Color(0xffff8d4f),
      letterSpacing: 4.32,
    ),
  );
}