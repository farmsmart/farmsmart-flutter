import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/assets.dart';

import 'discover_page.dart';

abstract class ArticleItemStyle {
  final TextStyle itemTitleStyle;
  final TextStyle itemSummaryStyle;

  final EdgeInsets itemListPadding;

  final double itemSpaceBetweenTextAndImage;
  final double itemSpaceBetweenTitleAndSummary;
  final double itemImageBorderRadius;
  final double itemImageSize;
  final double itemCardElevation;

  final int maxLinesPerTitle;
  final int maxLinesPerSummary;

  ArticleItemStyle(this.itemTitleStyle, this.itemSummaryStyle,
      this.itemListPadding, this.itemSpaceBetweenTextAndImage,
      this.itemSpaceBetweenTitleAndSummary, this.itemImageBorderRadius,
      this.itemImageSize, this.itemCardElevation, this.maxLinesPerTitle,
      this.maxLinesPerSummary);
}

class _DefaultArticleItemStyle implements ArticleItemStyle {
  static const Color titlesColor = Color(0xFF1a1b46);
  static const Color bodyColor = Color(0xFF767690);

  final TextStyle itemTitleStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: titlesColor);
  final TextStyle itemSummaryStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: bodyColor);

  final EdgeInsets itemListPadding = const EdgeInsets.only(left: 32.0, right: 32.0, top: 23, bottom: 23);

  final double itemSpaceBetweenTextAndImage = 30.5;
  final double itemImageBorderRadius = 10.0;
  final double itemImageSize = 80;
  final double itemSpaceBetweenTitleAndSummary = 9.5;
  final double itemCardElevation = 0;

  final int maxLinesPerTitle = 2;
  final int maxLinesPerSummary = 2;

  const _DefaultArticleItemStyle();
}

class ArticleListItem {
  Widget standardListItemBuilder(ArticleEntity articleData, Function getRelatedArticles, {ArticleItemStyle itemStyle = const _DefaultArticleItemStyle()}) {
    return GestureDetector(
      onTap: () => getRelatedArticles(articleData),
      child: Card(
        elevation: itemStyle.itemCardElevation,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: itemStyle.itemListPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildArticleInformation(articleData, itemStyle),
                    SizedBox(width: itemStyle.itemSpaceBetweenTextAndImage),
                    _buildListItemImage(articleData, itemStyle),
                  ],
                ),
              ),
              buildListDivider()
            ],
          ),
        ),
      ),
    );
  }

  _buildListItemImage(ArticleEntity articleData, ArticleItemStyle itemStyle) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(itemStyle.itemImageBorderRadius),
        child: NetworkImageFromFuture(
            articleData.imageUrl,
            height: itemStyle.itemImageSize,
            width: itemStyle.itemImageSize,
            fit: BoxFit.cover)
    );
  }

  _buildArticleInformation(ArticleEntity articleData, ArticleItemStyle itemStyle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(articleData.title ?? Strings.noTitleString,
              maxLines: itemStyle.maxLinesPerTitle,
              overflow: TextOverflow.ellipsis,
              style: itemStyle.itemTitleStyle),
          SizedBox(height: itemStyle.itemSpaceBetweenTitleAndSummary),
          Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
              maxLines: itemStyle.maxLinesPerSummary,
              overflow: TextOverflow.ellipsis,
              style: itemStyle.itemSummaryStyle),
        ],
      ),
    );
  }
}
