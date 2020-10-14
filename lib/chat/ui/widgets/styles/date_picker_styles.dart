import 'package:farmsmart_flutter/chat/ui/widgets/date_picker.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const defaultIsDenseList = true;
  static const defaultListTilePadding = const EdgeInsets.all(0);
  static const defaultLeftIconHeight = 20.0;
  static const defaultSizedBoxSeparatorWidth = 22.0;
  static const defaultPickerRowMainAxisAlignment =
      MainAxisAlignment.spaceBetween;
  static const defaultTrailingImageHeight = 13.0;
  static const defaultPickerDescriptionStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1A1B46),
  );
  static const defaultPickerValueStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0xFF767690),
  );
}

class DatePickerStyles {
  static DatePickerStyle buildDefaultStyle() => _defaultDatePickerStyles;

  static const _defaultDatePickerStyles = DatePickerStyle(
    pickerValueStyle: _Constants.defaultPickerValueStyle,
    pickerDescriptionStyle: _Constants.defaultPickerDescriptionStyle,
    trailingImageHeight: _Constants.defaultTrailingImageHeight,
    pickerRowMainAxisAlignment: _Constants.defaultPickerRowMainAxisAlignment,
    sizedBoxSeparatorWidth: _Constants.defaultSizedBoxSeparatorWidth,
    leftIconHeight: _Constants.defaultLeftIconHeight,
    listTilePadding: _Constants.defaultListTilePadding,
    isDenseList: _Constants.defaultIsDenseList,
    rowMainAxisAlignment: _Constants.defaultPickerRowMainAxisAlignment,
  );
}
