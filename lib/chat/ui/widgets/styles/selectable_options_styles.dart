import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/chat/ui/widgets/selectable_options.dart';

class SelectableOptionsStyles {
  static SelectableOptionsStyle buildDefaultStyle() =>
      _defaultSelectableOptionsStyle;

  static const _defaultSelectableOptionsStyle = SelectableOptionsStyle(
    outerContainerMargin: const EdgeInsets.all(0),
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
