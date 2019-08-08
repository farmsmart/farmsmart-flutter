import 'package:farmsmart_flutter/chat/ui/widgets/text_input.dart';
import 'package:flutter/material.dart';

class _Constants {
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
  static const defaultBoxDecorationBorderWidth = 1.0;
}

class TextInputStyles {
  static TextInputStyle buildDefaultStyle() => _defaultTextInputStyle;

  static const _defaultTextInputStyle = TextInputStyle(
    boxDecorationBorderWidth: _Constants.defaultBoxDecorationBorderWidth,
    boxDecorationBorderColor: _Constants.defaultBoxDecorationBorderColor,
    boxDecorationBorderRadius: _Constants.defaultBoxDecorationBorderRadius,
    buttonColor: _Constants.defaultButtonColor,
    textFormFieldContainerPadding:
        _Constants.defaultTextFormFieldContainerPadding,
    textFormFieldStyle: _Constants.defaultTextFormFieldStyle,
  );
}
