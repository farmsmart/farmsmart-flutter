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
  final Color separatorColor;

  final TextStyle titlePageStyle;
  final TextStyle dateStyle;
  final TextStyle bodyStyle;

  final EdgeInsets titlePadding;
  final EdgeInsets headerArticlePadding;
  final EdgeInsets itemListPadding;
  final EdgeInsets leftRightPadding;
  final EdgeInsets separatorIndentation;
  final EdgeInsets bodyPadding;

  final double separatorHeight;
  final double headerImageBorderRadius;
  final double itemImageBorderRadius;
  final double itemImageSize;
  final double spaceBetweenHeaderImageAndText;
  final double spaceBetweenTitleAndSummary;
  final double spaceBetweenItemTextAndImage;

  final int maxLinesPerTitle;
  final int maxLinesPerSummary;
  final int headerTitleMaxLines;
  final int headerSummaryMaxLines;

  final CrossAxisAlignment leftAlignmentHorizontal;
  final MainAxisAlignment centerAlignmentVertical;

  ArticlePageStyle(this.separatorColor, this.titlePageStyle, this.dateStyle,
      this.bodyStyle, this.titlePadding, this.headerArticlePadding,
      this.itemListPadding, this.leftRightPadding, this.separatorIndentation,
      this.bodyPadding, this.separatorHeight, this.headerImageBorderRadius,
      this.itemImageBorderRadius, this.itemImageSize,
      this.spaceBetweenHeaderImageAndText, this.spaceBetweenTitleAndSummary,
      this.spaceBetweenItemTextAndImage, this.maxLinesPerTitle,
      this.maxLinesPerSummary, this.headerTitleMaxLines,
      this.headerSummaryMaxLines, this.leftAlignmentHorizontal,
      this.centerAlignmentVertical);

}

class _ArticleDefaultStyle implements ArticlePageStyle {
  static const Color titlesColor = Color(0xFF1a1b46);
  static const Color footColor = Color(0xFF767690);
  static const Color bodyColor = Color(0xFF4c4e6e);
  final Color separatorColor = const Color(0xFFf5f8fa);

  final TextStyle titlePageStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: titlesColor);
  final TextStyle dateStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: footColor);
  final TextStyle bodyStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: bodyColor);

  final EdgeInsets titlePadding = const EdgeInsets.only(left: 34.0, right: 34.0, top: 35.0, bottom: 20.0);
  final EdgeInsets headerArticlePadding = const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 28);
  final EdgeInsets itemListPadding = const EdgeInsets.only(left: 32.0, right: 32.0, top: 23, bottom: 23);
  final EdgeInsets leftRightPadding = const EdgeInsets.only(left: 32.0, right: 32.0);
  final EdgeInsets separatorIndentation = const EdgeInsets.only(left: 32.0);
  final EdgeInsets bodyPadding = const EdgeInsets.only(left: 32.5, right: 45.0);

  final double separatorHeight = 2.0;
  final double headerImageBorderRadius = 14.0;
  final double itemImageBorderRadius = 10.0;
  final double itemImageSize = 80;
  final double spaceBetweenHeaderImageAndText = 22.0;
  final double spaceBetweenTitleAndSummary = 9.5;
  final double spaceBetweenItemTextAndImage = 30.5;

  final int maxLinesPerTitle = 2;
  final int maxLinesPerSummary = 2;
  final int headerTitleMaxLines = 1;
  final int headerSummaryMaxLines = 3;

  final CrossAxisAlignment leftAlignmentHorizontal = CrossAxisAlignment.start;
  final MainAxisAlignment centerAlignmentVertical = MainAxisAlignment.center;

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
  Widget build(BuildContext context, {ArticlePageStyle articleStyle = const _ArticleDefaultStyle()}) {
    return Scaffold(
      body: StoreConnector<AppState, DiscoverViewModel>(
        builder: (_, viewModel) => _buildBody(context, viewModel, articleStyle),
        converter: (store) => DiscoverViewModel.fromStore(store),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DiscoverViewModel viewModel, ArticlePageStyle articleStyle) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildArticlePage(context, viewModel.selectedArticleWithRelated, viewModel.getRelatedArticles, articleStyle);
      case LoadingStatus.ERROR:
        return Text("Error"); // TODO Check FARM-203
    }
  }
}

Widget _buildArticlePage(BuildContext context, ArticleEntity selectedArticle, Function getRelatedArticles, ArticlePageStyle articleStyle) {
  return Scaffold(
      appBar: CustomAppBar.buildForArticleDetail(selectedArticle.title, CustomAppBar.shareAction(selectedArticle.id)),
      body: ListView(
        children: <Widget>[
          _buildScreenTitle(selectedArticle.title, articleStyle),
          _buildArticlePublishingDate(selectedArticle, articleStyle),
          SizedBox(height: 36),
          _buildArticleImage(selectedArticle, articleStyle),
          SizedBox(height: 41.5),
          _buildArticleBody(selectedArticle, articleStyle),
          SizedBox(height: 41.0),
          _buildRelatedArticlesList(selectedArticle.relatedArticles, getRelatedArticles, articleStyle),
        ],
      ));
}

Widget _buildScreenTitle(String selectedArticleTitle, ArticlePageStyle articleStyle) {
  return Container(
      padding: articleStyle.titlePadding,
      child: Row(
        crossAxisAlignment: articleStyle.leftAlignmentHorizontal,
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
        crossAxisAlignment: articleStyle.leftAlignmentHorizontal,
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

Widget _buildArticleImage(ArticleEntity selectedArticle, ArticlePageStyle articleStyle) {
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
  const String titleRelatedArticles = "Related Articles";

  if (!relatedArticles.isEmpty) {
    return Column(
      children: <Widget>[
        _buildScreenTitle(titleRelatedArticles, articleStyle),
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
