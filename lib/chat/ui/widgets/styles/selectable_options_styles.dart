import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/selectable_options.dart';

class _Constants {
  static const defaultOuterContainerHorizontalMargin = 32.0;
}

class SelectableOptionsStyles {
  static SelectableOptionsStyle buildDefaultStyle() =>
      _defaultSelectableOptionsStyle;

  static const _defaultSelectableOptionsStyle = SelectableOptionsStyle(
    outerContainerMargin: const EdgeInsets.only(
      left: _Constants.defaultOuterContainerHorizontalMargin,
      top: 31.0,
      right: 51.0,
      bottom: 32.0,
    ),
    wrapSpacing: 12.0,
    wrapRunAlignment: WrapAlignment.spaceEvenly,
    wrapDirection: Axis.horizontal,
    wrapAlignment: WrapAlignment.start,
    optionTextStyle: TextStyle(
      fontSize: 15.0,
      color: const Color(0xFFFFFFFF),
      fontWeight: FontWeight.bold,
    ),
    optionTextAlign: TextAlign.center,
    optionPadding: EdgeInsets.symmetric(
      horizontal: 24.0,
      vertical: 17.0,
    ),
    optionDecoration: const BoxDecoration(
      color: Color(0xFF24d900),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    optionMargin: EdgeInsets.only(bottom: 12.0),
  );
}
