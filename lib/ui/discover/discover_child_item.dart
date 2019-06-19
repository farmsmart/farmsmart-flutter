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

  final double imageLineSpace;
  final double textLineSpace;
  final double imageBorderRadius;
  final double imageSize;
  final double cardElevation;

  final int maxLinesPerTitle;
  final int maxLinesPerSummary;

  ArticleListItemStyle(this.titleTextStyle, this.summaryTextStyle,
      this.listEdgePadding, this.imageLineSpace,
      this.textLineSpace, this.imageBorderRadius,
      this.imageSize, this.cardElevation, this.maxLinesPerTitle,
      this.maxLinesPerSummary);
}

class _DefaultArticleListItemStyle implements ArticleListItemStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color bodyColor = Color(0xFF767690);

  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: titleColor);
  final TextStyle summaryTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: bodyColor);

  final EdgeInsets listEdgePadding = const EdgeInsets.only(left: 32.0, right: 32.0, top: 23, bottom: 23);

  final double imageLineSpace = 30.5;
  final double imageBorderRadius = 10.0;
  final double imageSize = 80;
  final double textLineSpace = 9.5;
  final double cardElevation = 0;

  final int maxLinesPerTitle = 2;
  final int maxLinesPerSummary = 2;

  const _DefaultArticleListItemStyle();
}

class ArticleListItem {
  Widget standardListItemBuilder(ArticlesItemListViewModel viewModel, {ArticleListItemStyle itemStyle = const _DefaultArticleListItemStyle()}) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Card(
        elevation: itemStyle.cardElevation,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: itemStyle.listEdgePadding,
                child: Row(
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
      ),
    );
  }

  _buildListItemImage(ArticlesItemListViewModel articleData, ArticleListItemStyle itemStyle) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(itemStyle.imageBorderRadius),
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
