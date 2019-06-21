import 'package:flutter/material.dart';

abstract class ArticleListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle summaryTextStyle;

  final EdgeInsets listEdgePadding;
  final EdgeInsets cardMargin;

  final double imageHeight;
  final double imageLineSpace;
  final double textLineSpace;
  final double cardElevation;

  final BorderRadius imageBorderRadius;

  final int maxLinesPerTitle;
  final int maxLinesPerSummary;

  ArticleListItemStyle(
      this.titleTextStyle,
      this.summaryTextStyle,
      this.listEdgePadding,
      this.cardMargin,
      this.imageHeight,
      this.imageLineSpace,
      this.textLineSpace,
      this.cardElevation,
      this.imageBorderRadius,
      this.maxLinesPerTitle,
      this.maxLinesPerSummary);
}
