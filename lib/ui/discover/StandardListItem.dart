import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/assets.dart';

import 'discover_page.dart';


abstract class ArticleListItemStyle {
  final TextStyle titleTextStyle;
  final TextStyle summaryTextStyle;

  final EdgeInsets listEdgePadding;
  final EdgeInsets cardMargin;

  final double imageLineSpace;
  final double textLineSpace;
  final double imageSize;
  final double cardElevation;

  final BorderRadius imageBorderRadius;

  final int maxLinesPerTitle;
  final int maxLinesPerSummary;

  ArticleListItemStyle(this.titleTextStyle, this.summaryTextStyle,
      this.listEdgePadding, this.cardMargin, this.imageLineSpace,
      this.textLineSpace, this.imageSize, this.cardElevation,
      this.imageBorderRadius, this.maxLinesPerTitle, this.maxLinesPerSummary);

}

class _DefaultArticleListItemStyle implements ArticleListItemStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color bodyColor = Color(0xFF767690);

  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: titleColor);
  final TextStyle summaryTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: bodyColor);

  final EdgeInsets listEdgePadding = const EdgeInsets.only(left: 32.0, right: 32.0, top: 23, bottom: 23);
  final EdgeInsets cardMargin = const EdgeInsets.all(0);


  final double imageLineSpace = 30.5;
  final double imageSize = 80;
  final double textLineSpace = 9.5;
  final double cardElevation = 0;

  final BorderRadius imageBorderRadius = const BorderRadius.all(Radius.circular(10.0));

  final int maxLinesPerTitle = 2;
  final int maxLinesPerSummary = 2;

  const _DefaultArticleListItemStyle();
}

class HeroArticleListItemStyle implements ArticleListItemStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color textColor = Color(0xFF767690);

  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: titleColor);
  final TextStyle summaryTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: textColor);

  final EdgeInsets listEdgePadding = const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 28);
  final EdgeInsets cardMargin = const EdgeInsets.all(0);

  final double imageLineSpace = 22;
  final double imageSize = 80;
  final double textLineSpace = 9.5;
  final double cardElevation = 0;

  final BorderRadius imageBorderRadius = const BorderRadius.all(Radius.circular(14.0));

  final int maxLinesPerTitle = 1;
  final int maxLinesPerSummary = 3;

  const HeroArticleListItemStyle();
}

class StandardListItem {
  Widget builder(ArticlesItemListViewModel viewModel, {ArticleListItemStyle itemStyle = const _DefaultArticleListItemStyle()}) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Card(
        margin: itemStyle.cardMargin,
        elevation: itemStyle.cardElevation,
        child: Column(
          children: <Widget>[
            Container(
              padding: itemStyle.listEdgePadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildArticleInformation(viewModel, itemStyle),
                  SizedBox(width: itemStyle.imageLineSpace),
                  _buildListItemImage(viewModel, itemStyle),
                ],
              ),
            ),
            buildListDivider()
          ],
        ),
      ),
    );
  }

  _buildListItemImage(ArticlesItemListViewModel articleData, ArticleListItemStyle itemStyle) {
    return ClipRRect(
        borderRadius: itemStyle.imageBorderRadius,
        child: NetworkImageFromFuture(
            articleData.imageUrl,
            height: itemStyle.imageSize,
            width: itemStyle.imageSize,
            fit: BoxFit.cover)
    );
  }

  _buildArticleInformation(ArticlesItemListViewModel articleData, ArticleListItemStyle itemStyle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(articleData.title ?? Strings.noTitleString,
              maxLines: itemStyle.maxLinesPerTitle,
              overflow: TextOverflow.ellipsis,
              style: itemStyle.titleTextStyle),
          SizedBox(height: itemStyle.textLineSpace),
          Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
              maxLines: itemStyle.maxLinesPerSummary,
              overflow: TextOverflow.ellipsis,
              style: itemStyle.summaryTextStyle),
        ],
      ),
    );
  }
}
