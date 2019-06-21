import 'package:flutter/material.dart';

abstract class _DividerStyle {
  final Color color;
  final EdgeInsets edgePadding;
  final double height;

  _DividerStyle(this.color, this.edgePadding, this.height);
}

class _DefaultDividerStyle implements _DividerStyle {
  final Color color = const Color(0xFFf5f8fa);
  final EdgeInsets edgePadding = const EdgeInsets.only(left: 32.0);
  final double height = 2.0;

  const _DefaultDividerStyle();
}

class ListDivider {
  static build({_DividerStyle dividerStyle = const _DefaultDividerStyle()}) {
     return Container(
      height: dividerStyle.height,
      color: dividerStyle.color,
      margin: dividerStyle.edgePadding);
  }
}
