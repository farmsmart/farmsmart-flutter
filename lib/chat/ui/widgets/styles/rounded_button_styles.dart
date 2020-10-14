import 'package:farmsmart_flutter/chat/ui/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const defaultWidth = 24.0;
  static const defaultHeight = 24.0;
  static const defaultIconPadding = 0.0;
  static const defaultIconSize = 9.0;
  static const defaultIconButtonColor = Color(0xFFFFFFFF);
  static const defaultButtonShape = BoxShape.rectangle;
  static const defaultBorderRadius = BorderRadius.all(Radius.circular(20));
  static const defaultBackgroundColor = Color(0xFF24D900);
}

class RoundedButtonStyles {
  static RoundedButtonStyle buildDefaultStyle() => _defaultStyle;

  static RoundedButtonStyle bigRoundedButton() => _defaultStyle.copyWith(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        height: 48.0,
        width: 48.0,
        buttonIconSize: 14.0,
      );

  static RoundedButtonStyle largeRoundedButtonStyle() => _defaultStyle.copyWith(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        buttonTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFFFFF),
        ),
        iconEdgePadding: 5,
        height: 56,
        width: double.infinity,
        buttonIconSize: null,
      );

  static RoundedButtonStyle actionSheetLargeRoundedButton() =>
      _defaultStyle.copyWith(
        backgroundColor: Color(0xFFE9EAF2),
        buttonTextStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Color(0xFF4C4E6E),
        ),
      );

  static RoundedButtonStyle chatButtonStyle() =>
      largeRoundedButtonStyle().copyWith(
        height: 48.0,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        buttonTextStyle: TextStyle(
          fontSize: 15.0,
          color: Color(0xFFFFFFFF),
        ),
      );

  static const _defaultStyle = RoundedButtonStyle(
    width: _Constants.defaultWidth,
    height: _Constants.defaultHeight,
    iconEdgePadding: _Constants.defaultIconPadding,
    iconButtonColor: _Constants.defaultIconButtonColor,
    buttonShape: _Constants.defaultButtonShape,
    buttonIconSize: _Constants.defaultIconSize,
    borderRadius: _Constants.defaultBorderRadius,
    backgroundColor: _Constants.defaultBackgroundColor,
  );
}
