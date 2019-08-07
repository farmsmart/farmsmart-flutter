import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/selectable_options.dart';

class _Constants {
  static const defaultOuterContainerMargin = const EdgeInsets.all(0);

  static const defaultWrapSpacing = 12.0;
  static const defaultWrapRunAlignment = WrapAlignment.spaceEvenly;
  static const defaultWrapDirection = Axis.horizontal;
  static const defaultWrapAlignment = WrapAlignment.start;
  static const defaultOptionTextStyle = TextStyle(
    fontSize: 15.0,
    color: const Color(0xFFFFFFFF),
  );
  static const defaultOptionTextAlign = TextAlign.center;
  static const defaultOptionPadding = const EdgeInsets.symmetric(
    horizontal: 24.0,
    vertical: 17.0,
  );
  static const defaultOptionDecoration = const BoxDecoration(
    color: Color(0xFF24D900),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  );
  static const defaultOptionMargin = EdgeInsets.only(bottom: 12.0);
}

class SelectableOptionsStyles {
  static SelectableOptionsStyle buildDefaultStyle() =>
      _defaultSelectableOptionsStyle;

  static const _defaultSelectableOptionsStyle = SelectableOptionsStyle(
    outerContainerMargin: _Constants.defaultOuterContainerMargin,
    wrapSpacing: _Constants.defaultWrapSpacing,
    wrapRunAlignment: _Constants.defaultWrapRunAlignment,
    wrapDirection: _Constants.defaultWrapDirection,
    wrapAlignment: _Constants.defaultWrapAlignment,
    optionTextStyle: _Constants.defaultOptionTextStyle,
    optionTextAlign: _Constants.defaultOptionTextAlign,
    optionDecoration: _Constants.defaultOptionDecoration,
    optionMargin: _Constants.defaultOptionMargin,
    optionPadding: _Constants.defaultOptionPadding,
  );
}
