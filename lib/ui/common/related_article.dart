
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/related_articles.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class RelatedArticle {

  /// Builds a Related Articles footer what opens up a Bottom sheet when related articles is clicked.
  static List<Widget> buildRelatedArticlesFooter(GlobalKey scaffold, IsRelatedArticlesEntity relatedArticles, Function getRelatedArticles) {

    if (relatedArticles == null || relatedArticles.getRelatedArticles().isEmpty) {
      return null;
    } else {
      return [FlatButton(
        child: Text('Related Articles'),
        onPressed: () {
          showBottomSheet(
              context: scaffold.currentContext,
              builder: (buildContext) {
                return _buildRelated(
                    buildContext, relatedArticles.getRelatedArticles(),
                        (article) {
                      Navigator.pop(scaffold.currentContext);
                      getRelatedArticles(article);
                    });
              }
          );
        },
      )
      ];
    }
  }

  static Widget _buildRelated(BuildContext context, List<ArticleEntity> articlesList, Function getRelatedArticles) {
    return Container(
        height: null,
        child: SingleChildScrollView(
            child : Column(
                mainAxisSize: MainAxisSize.min,
                children: (articlesList != null) ? (articlesList.map((article) =>
                    _buildListOfRelatedArticles(article, getRelatedArticles)).toList()) : null)));
  }

  static Widget _buildListOfRelatedArticles(ArticleEntity articleData, Function getRelatedArticles) {
    return GestureDetector(
        onTap: () {
          getRelatedArticles(articleData);
        },
        child: Padding(
          key: ValueKey(articleData.title ?? Strings.noTitleString),
          padding: Paddings.listOfArticlesPadding(),
          child: Container(
              height: listItemHeight,
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
                  Dividers.listDividerLine(),
                ],
              )),
        ));
  }

  static _buildListItemImage(ArticleEntity articleData) {
    return NetworkImageFromFuture(
        articleData.imageUrl,
        height: listImageHeight,
        width: listImageWidth,
        fit: BoxFit.cover
    );
  }

  static _buildArticleTitle(ArticleEntity articleData) {
    return Expanded(
      flex: listViewFlex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(articleData.title ?? Strings.noTitleString,
              maxLines: titleMaxLines,
              overflow: TextOverflow.ellipsis,
              style: Styles.articleListTitleStyle()),
          Margins.generalListSmallerMargin(),
          Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
              maxLines: summaryMaxLines,
              overflow: TextOverflow.ellipsis,
              style: Styles.footerTextStyle()),
        ],
      ),
    );
  }

  static _buildListIcon() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.arrow_forward_ios,
            size: arrowIconSize,
            color: Color(primaryGrey),
          ),
        ],
      ),
    );
  }

}