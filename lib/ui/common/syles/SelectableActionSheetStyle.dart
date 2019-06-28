import 'package:farmsmart_flutter/ui/common/widgets/ActionSheet.dart';
import 'package:flutter/material.dart';

class SelectableActionSheetStyle implements ActionSheetStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color highlightColor = Color(0xFFff6060);

  final Color cornersColor = const Color(0xFF737373);
  final Color backgroundColor = const Color(0xFFffffff);
  final Color dropLineColor = const Color(0xFFe0e1ee);
  final Color cardBackgroundColor = const Color(0x00000000);

  final TextStyle mainTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: titleColor);
  final TextStyle highlightTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: highlightColor);

  final EdgeInsets cardEdge = const EdgeInsets.only(left: 32, right: 32);
  final EdgeInsets dropLineEdge = const EdgeInsets.only(left: 160, right: 160, top: 8, bottom: 50);

  final Radius borderRadius = const Radius.circular(40);
  final Radius dropLineRadius = const Radius.circular(2.5);

  final double dropLineHeight = 5;
  final double cardHeight = 70;
  final double iconLineSpace = 21.5;
  final double cardElevation = 0;
  final double iconHeight = 24;

  final int maxLines = 1;

  const SelectableActionSheetStyle();
}
