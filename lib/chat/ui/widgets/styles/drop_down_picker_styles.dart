import 'package:farmsmart_flutter/chat/ui/widgets/drop_down_picker.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const defaultListTileOffset = const Offset(90, 0);
  static const defaultListTileContentPadding = const EdgeInsets.all(0.0);
  static const defaultIsListTileDense = true;
  static const defaultRowMainAxisAlignment = MainAxisAlignment.start;
  static const defaultLeftIconHeight = 20.0;
  static const defaultSizedBoxSeparationWidth = 22.0;
  static const defaultRightChildMainAxisAlignment =
      MainAxisAlignment.spaceBetween;
  static const defaultOptionDescriptionStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: Color(0xFF1a1b46),
  );
  static const defaultBasePickedOptionValueStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0x4c767690),
  );
  static const defaultPickedOptionValueStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: Color(0xff767690),
  );
  static const defaultTrailingImageHeight = 13.0;
}

class DropDownPickerStyles {
  static DropDownPickerStyle buildDefaultStyle() => _defaultDropDownPickerStyle;

  static const _defaultDropDownPickerStyle = DropDownPickerStyle(
    listTileOffset: _Constants.defaultListTileOffset,
    listTileContentPadding: _Constants.defaultListTileContentPadding,
    isListTileDense: _Constants.defaultIsListTileDense,
    rowMainAxisAlignment: _Constants.defaultRowMainAxisAlignment,
    leftIconHeight: _Constants.defaultLeftIconHeight,
    sizedBoxSeparationWidth: _Constants.defaultSizedBoxSeparationWidth,
    rightChildMainAxisAlignment: _Constants.defaultRightChildMainAxisAlignment,
    optionDescriptionStyle: _Constants.defaultOptionDescriptionStyle,
    basePickedOptionValueStyle: _Constants.defaultBasePickedOptionValueStyle,
    pickedOptionValueStyle: _Constants.defaultPickedOptionValueStyle,
    trailingImageHeight: _Constants.defaultTrailingImageHeight,
  );
}
