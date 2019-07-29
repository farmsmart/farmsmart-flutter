import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItem.dart';
import 'package:flutter/material.dart';

class RecordTransactionListItemStyles {
  static RecordTransactionListItemStyle _defaultStyle = RecordTransactionListItemStyle(
      titleTextStyle: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1a1b46),
      ),
      pendingDetailTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Color(0x4c767690),
      ),
      detailTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Color(0xff767690),
      ),
      actionItemEdgePadding:
          EdgeInsets.only(left: 32, right: 32, top: 25, bottom: 25),
      cardMargins: EdgeInsets.all(0),
      pickerPosition: Offset(90, 0),
      iconHeight: 20,
      iconLineSpace: 22,
      detailTextSpacing: 13,
      descriptionLineSpace: 12,
      maxLines: 5);

  static RecordTransactionListItemStyle biggerStyle = _defaultStyle.copyWith(
    detailTextStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.normal,
      color: Color(0xff1a1b46),
    ),
    pendingDetailTextStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.normal,
      color: Color(0x4c1a1b46),
    ),
  );
}
