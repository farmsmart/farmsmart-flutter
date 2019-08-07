import 'package:farmsmart_flutter/chat/ui/widgets/text_input.dart';
import 'package:flutter/material.dart';

class _Constants {
  static const defaultFormContainerMargin = const EdgeInsets.all(0.0);
  static const defaultFormRowMainAxisSize = MainAxisSize.max;
  static const defaultFormRowMainAxisAlignment = MainAxisAlignment.spaceBetween;
  static const defaultTextFormFieldFlex = 4;
  static const defaultButtonFlex = 1;
  static const defaultTextFormFieldContainerPadding =
      const EdgeInsets.symmetric(horizontal: 16.0);
  static const defaultTextFormFieldStyle = const TextStyle(
    color: Color(0xFF1A1B46),
    fontSize: 15.0,
  );
  static const defaultButtonColor = const Color(0xFF00CD9F);
  static const defaultBoxDecorationBorderRadius =
      const BorderRadius.all(Radius.circular(20.0));
  static const defaultBoxDecorationBorderColor = const Color(0xFFE9EAF2);
  static const defaultBoxDecorationBorderWidth = 2.0;
  static const defaultSizedBoxSeparatorWidth = 10.0;
}

class TextInputStyles {
  static TextInputStyle buildDefaultStyle() => _defaultTextInputStyle;

  static const _defaultTextInputStyle = TextInputStyle(
    sizedBoxSeparatorWidth: _Constants.defaultSizedBoxSeparatorWidth,
    boxDecorationBorderWidth: _Constants.defaultBoxDecorationBorderWidth,
    boxDecorationBorderColor: _Constants.defaultBoxDecorationBorderColor,
    boxDecorationBorderRadius: _Constants.defaultBoxDecorationBorderRadius,
    buttonColor: _Constants.defaultButtonColor,
    buttonFlex: _Constants.defaultButtonFlex,
    formContainerMargin: _Constants.defaultFormContainerMargin,
    formRowMainAxisAlignment: _Constants.defaultFormRowMainAxisAlignment,
    formRowMainAxisSize: _Constants.defaultFormRowMainAxisSize,
    textFormFieldContainerPadding:
        _Constants.defaultTextFormFieldContainerPadding,
    textFormFieldFlex: _Constants.defaultTextFormFieldFlex,
    textFormFieldStyle: _Constants.defaultTextFormFieldStyle,
  );
}
