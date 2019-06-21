import 'package:flutter/material.dart';

abstract class DividerStyle {
  final Color color;
  final EdgeInsets edgePadding;
  final double height;

  DividerStyle(this.color, this.edgePadding, this.height);
}

class DefaultDividerStyle implements DividerStyle {
  final Color color = const Color(0xFFf5f8fa);
  final EdgeInsets edgePadding = const EdgeInsets.only(left: 32.0);
  final double height = 2.0;

  const DefaultDividerStyle();
}

class ListDivider {
  static build({DividerStyle dividerStyle = const DefaultDividerStyle()}) {
     return Container(
      height: dividerStyle.height,
      color: dividerStyle.color,
      margin: dividerStyle.edgePadding);
  }
}