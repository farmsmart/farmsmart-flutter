import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/assets.dart';

import 'discover_page.dart';

class DiscoveryListItem {
  Widget buildListItem(ArticleEntity articleData, Function getRelatedArticles, HomeDiscoverPageStyle discoverStyle) {
    return GestureDetector(
      onTap: () => getRelatedArticles(articleData),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: discoverStyle.itemListPadding,
              child: Row(
                mainAxisAlignment: discoverStyle.centerAlignmentVertical,
                children: <Widget>[
                  _buildArticleInformation(articleData, discoverStyle),
                  SizedBox(width: discoverStyle.spaceBetweenItemTextAndImage),
                  _buildListItemImage(articleData, discoverStyle),
                ],
              ),
            ),
            buildListSeparator(discoverStyle)
          ],
        ),
      ),
    );
  }

  _buildListItemImage(ArticleEntity articleData, HomeDiscoverPageStyle discoverStyle) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(discoverStyle.itemImageBorderRadius),
        child: NetworkImageFromFuture(
            articleData.imageUrl,
            height: discoverStyle.itemImageSize,
            width: discoverStyle.itemImageSize,
            fit: BoxFit.cover)
    );
  }

  _buildArticleInformation(ArticleEntity articleData, HomeDiscoverPageStyle discoverStyle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: discoverStyle.leftAlignmentHorizontal,
        children: <Widget>[
          Text(articleData.title ?? Strings.noTitleString,
              maxLines: discoverStyle.maxLinesPerTitle,
              overflow: TextOverflow.ellipsis,
              style: discoverStyle.titleArticleStyle),
          SizedBox(height: discoverStyle.spaceBetweenTitleAndSummary),
          Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
              maxLines: discoverStyle.maxLinesPerSummary,
              overflow: TextOverflow.ellipsis,
              style: discoverStyle.summaryArticleStyle),
        ],
      ),
    );
  }
}
