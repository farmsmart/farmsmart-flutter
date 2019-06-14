import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import '../app_bar.dart';
import 'discover_child_item.dart';
import 'discover_viewmodel.dart';

abstract class ArticlePageStyle {
  final String RELATED_ARTICLES;

  final TextStyle titlePageStyle;
  final TextStyle dateStyle;
  final TextStyle bodyStyle;

  final EdgeInsets titlePagePadding;
  final EdgeInsets leftRightPadding;
  final EdgeInsets bodyPadding;

  final double spaceBetweenDataAndImage;
  final double spaceBetweenElements;

  final int maxLinesPerTitle;

  ArticlePageStyle(this.RELATED_ARTICLES, this.titlePageStyle, this.dateStyle,
      this.bodyStyle, this.titlePagePadding, this.leftRightPadding,
      this.bodyPadding, this.spaceBetweenDataAndImage,
      this.spaceBetweenElements,
      this.maxLinesPerTitle);
}

class _ArticleDefaultStyle implements ArticlePageStyle {
  final String RELATED_ARTICLES = "Related Articles";

  static const Color titlesColor = Color(0xFF1a1b46);
  static const Color footColor = Color(0xFF767690);
  static const Color bodyColor = Color(0xFF4c4e6e);

  final TextStyle titlePageStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: titlesColor);
  final TextStyle dateStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: footColor);
  final TextStyle bodyStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: bodyColor);

  final EdgeInsets titlePagePadding = const EdgeInsets.only(left: 34.0, right: 34.0, top: 35.0, bottom: 20.0);
  final EdgeInsets leftRightPadding = const EdgeInsets.only(left: 32.0, right: 32.0);
  final EdgeInsets bodyPadding = const EdgeInsets.only(left: 32.5, right: 45.0);

  final double spaceBetweenDataAndImage = 36;
  final double spaceBetweenElements = 41;

  final int maxLinesPerTitle = 2;

  const _ArticleDefaultStyle();
}


class ArticleDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState extends State<ArticleDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, DiscoverViewModel>(
        builder: (_, viewModel) => _buildBody(context, viewModel),
        converter: (store) => DiscoverViewModel.fromStore(store),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DiscoverViewModel viewModel) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildArticlePage(context, viewModel.selectedArticleWithRelated, viewModel.getRelatedArticles);
      case LoadingStatus.ERROR:
        return Text("Error"); // TODO Check FARM-203
    }
  }
}

Widget _buildArticlePage(BuildContext context, ArticleEntity selectedArticle, Function getRelatedArticles, {ArticlePageStyle articleStyle = const _ArticleDefaultStyle()}) {
  return Scaffold(
      appBar: CustomAppBar.buildForArticleDetail(selectedArticle.title, CustomAppBar.shareAction(selectedArticle.id)),
      body: ListView(
        children: <Widget>[
          _buildScreenTitle(selectedArticle.title, articleStyle),
          _buildArticlePublishingDate(selectedArticle, articleStyle),
          SizedBox(height: articleStyle.spaceBetweenDataAndImage),
          _buildArticleImage(selectedArticle),
          SizedBox(height: articleStyle.spaceBetweenElements),
          _buildArticleBody(selectedArticle, articleStyle),
          SizedBox(height: articleStyle.spaceBetweenElements),
          _buildRelatedArticlesList(selectedArticle.relatedArticles, getRelatedArticles, articleStyle),
        ],
      ));
}

// FIXME: Reuse the _buildScreenTitle from discover page (don't need to redefine here)
Widget _buildScreenTitle(String selectedArticleTitle, ArticlePageStyle articleStyle) {
  return Container(
      padding: articleStyle.titlePagePadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              selectedArticleTitle,
              style: articleStyle.titlePageStyle,
              maxLines: articleStyle.maxLinesPerTitle,
            ),
          )
        ],
      ));
}

Widget _buildArticlePublishingDate(ArticleEntity selectedArticle, ArticlePageStyle articleStyle) {
  return Container(
      padding: articleStyle.leftRightPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              "14th May - 6 minute read",
              style: articleStyle.dateStyle,
            ),
          )
        ],
      ));
}

Widget _buildArticleImage(ArticleEntity selectedArticle) {
  return Container(
      child: NetworkImageFromFuture(selectedArticle.imageUrl,
          fit: BoxFit.cover, height: 192.0));
}

Widget _buildArticleBody(ArticleEntity selectedArticle, ArticlePageStyle articleStyle) {
  return Container(
      padding: articleStyle.bodyPadding,
      child: Html(data: selectedArticle.content, useRichText: true));
}

Widget _buildRelatedArticlesList(List<ArticleEntity> relatedArticles, Function getRelatedArticles, ArticlePageStyle articleStyle) {
  if (!relatedArticles.isEmpty) {
    return Column(
      children: <Widget>[
        _buildScreenTitle(articleStyle.RELATED_ARTICLES, articleStyle),
        ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: relatedArticles.length,
            itemBuilder: (BuildContext context, int index) {
              return DiscoveryListItem().buildListItem(relatedArticles[index], getRelatedArticles);
            })
      ],
    );
  }
}
