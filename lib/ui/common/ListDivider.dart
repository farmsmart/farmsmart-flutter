import 'package:flutter/material.dart';

abstract class DividerStyle {
  final Color color;
  final EdgeInsets edgePadding;
  final double height;

  DividerStyle(this.color, this.edgePadding, this.height);
}

class DefaultStyle implements DividerStyle {
  final Color color = const Color(0xFFf5f8fa);
  final EdgeInsets edgePadding = const EdgeInsets.only(left: 32.0);
  final double height = 2.0;

  const DefaultStyle();
}

class ListDivider {
  static build({DividerStyle dividerStyle = const DefaultStyle()}) {
     return Container(
      height: dividerStyle.height,
      color: dividerStyle.color,
      margin: dividerStyle.edgePadding);
  }
}
