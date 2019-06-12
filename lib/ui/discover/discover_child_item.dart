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
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 23, bottom: 23),
              child: Row(
                children: <Widget>[
                  _buildArticleTitle(articleData),
                  Padding(padding: EdgeInsets.all(8.0)),
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

  /*Widget buildListItem(ArticleEntity articleData, Function getRelatedArticles) {
    return GestureDetector(
        onTap: () {
          getRelatedArticles(articleData);
        },
        child: Padding(
          key: ValueKey(articleData.title ?? Strings.noTitleString),
          padding: Paddings.listOfArticlesPadding(),
          child: Container(
              height: 101,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildListItemImage(articleData),
                      Padding(
                        padding: Paddings.leftPaddingSmall(),
                      ),
                      _buildArticleTitle(articleData),
                      _buildListIcon(),
                      Padding(
                        padding: Paddings.rightPaddingSmall(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: Paddings.bottomPaddingSmall(),
                  ),
                  Dividers.listDividerLine()
                ],
              )),
        ));
  } */


  _buildListItemImage(ArticleEntity articleData) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: NetworkImageFromFuture(
            articleData.imageUrl,
            height: 85,
            width: 85,
            fit: BoxFit.cover)
    );
  }

  _buildArticleTitle(ArticleEntity articleData) {
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
