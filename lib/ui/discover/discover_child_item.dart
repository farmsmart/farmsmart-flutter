import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/assets.dart';

class DiscoveryListItem {
  Widget buildListItem(ArticleEntity articleData, Function getRelatedArticles) {
    return GestureDetector(
      onTap: () => getRelatedArticles(articleData),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 23, bottom: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildArticleInformation(articleData),
                  Margins.spaceBetweenTextAndPicture(),
                  _buildListItemImage(articleData),
                ],
              ),
            ),
            Dividers.listDividerLine()
          ],
        ),
      ),
    );
  }

  _buildListItemImage(ArticleEntity articleData) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: NetworkImageFromFuture(
            articleData.imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.cover)
    );
  }

  _buildArticleInformation(ArticleEntity articleData) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(articleData.title ?? Strings.noTitleString,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.articleListTitleStyle()),
          Margins.generalListSmallerMargin(),
          Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.articleSummaryTextStyle()),
        ],
      ),
    );
  }
}
