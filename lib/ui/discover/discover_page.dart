import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/discover/discover_child_item.dart';
import 'package:farmsmart_flutter/ui/discover/discover_viewmodel.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';

abstract class ArticleListStyle {
  final Color separatorColor;

  final TextStyle titlePageStyle;
  final TextStyle headerArticleTitleStyle;
  final TextStyle headerArticleSummaryStyle;

  final EdgeInsets titlePagePadding;
  final EdgeInsets headerArticlePadding;
  final EdgeInsets separatorIndentation;

  final double separatorHeight;
  final double headerImageBorderRadius;
  final double spaceBetweenHeaderImageAndText;
  final double spaceBetweenTitleAndSummary;

  final int headerTitleMaxLines;
  final int headerSummaryMaxLines;

  final CrossAxisAlignment leftAlignmentHorizontal;
  final MainAxisAlignment centerAlignmentVertical;

  ArticleListStyle(this.separatorColor, this.titlePageStyle,
      this.headerArticleTitleStyle, this.headerArticleSummaryStyle, this.titlePagePadding,
      this.headerArticlePadding,
      this.separatorIndentation, this.separatorHeight,
      this.headerImageBorderRadius, this.spaceBetweenHeaderImageAndText,
      this.spaceBetweenTitleAndSummary, this.headerTitleMaxLines,
      this.headerSummaryMaxLines, this.leftAlignmentHorizontal,
      this.centerAlignmentVertical);
}

class _ArticleListDefaultStyle implements ArticleListStyle {
  static const Color titlesColor = Color(0xFF1a1b46);
  static const Color bodyColor = Color(0xFF767690);
  final Color separatorColor = const Color(0xFFf5f8fa);

  final TextStyle titlePageStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: titlesColor);
  final TextStyle headerArticleTitleStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: titlesColor);
  final TextStyle headerArticleSummaryStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: bodyColor);

  final EdgeInsets titlePagePadding = const EdgeInsets.only(left: 34.0, right: 34.0, top: 35.0, bottom: 30.0);
  final EdgeInsets headerArticlePadding = const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 28);
  final EdgeInsets separatorIndentation = const EdgeInsets.only(left: 32.0);

  final double separatorHeight = 2.0;
  final double headerImageBorderRadius = 14.0;

  final double spaceBetweenHeaderImageAndText = 22.0;
  final double spaceBetweenTitleAndSummary = 9.5;

  final int headerTitleMaxLines = 1;
  final int headerSummaryMaxLines = 3;

  final CrossAxisAlignment leftAlignmentHorizontal = CrossAxisAlignment.start;
  final MainAxisAlignment centerAlignmentVertical = MainAxisAlignment.center;

  const _ArticleListDefaultStyle();
}


class ArticleList extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _DiscoveryState();
  }
}

class _DiscoveryState extends State<ArticleList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, DiscoverViewModel>(
          onInit: (store) => store.dispatch(new FetchArticleDirectoryAction()),
          builder: (_, viewModel) => _buildBody(context, viewModel),
          converter: (store) => DiscoverViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, DiscoverViewModel viewModel) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildDiscoverPage(context, viewModel.articleDirectory.articles, viewModel.getRelatedArticles);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }
}

  Widget _buildDiscoverPage(BuildContext context, List<ArticleEntity> articlesList, Function getRelatedArticles, {ArticleListStyle articleListStyle = const _ArticleListDefaultStyle()}) {
    return ListView(
      children: <Widget>[
        _buildScreenTitle(articleListStyle),
        _buildArticlesList(articlesList, getRelatedArticles, articleListStyle)
      ],
    );
  }

  Widget _buildScreenTitle(ArticleListStyle articleListStyle) {
    return Container(
      padding: articleListStyle.titlePagePadding,
      child: Row(
        crossAxisAlignment: articleListStyle.leftAlignmentHorizontal,
        children: <Widget>[
          Text(Strings.discoverTab, style: articleListStyle.titlePageStyle)
        ],
      ),
    );
  }

  Widget _heroListItemBuilder(ArticleEntity firstArticle, ArticleListStyle articleListStyle) {
    return Column(
          children: <Widget>[
            Container(
              padding: articleListStyle.headerArticlePadding,
              child: Column(
                crossAxisAlignment: articleListStyle.leftAlignmentHorizontal,
                children: <Widget>[
                  _buildHeaderArticleImage(firstArticle, articleListStyle),
                  SizedBox(height: articleListStyle.spaceBetweenHeaderImageAndText),
                  Text(
                      firstArticle.title,
                      maxLines: articleListStyle.headerTitleMaxLines,
                      style: articleListStyle.headerArticleTitleStyle
                  ),
                  SizedBox(height: articleListStyle.spaceBetweenTitleAndSummary),
                  Text(
                      firstArticle.summary,
                      maxLines: articleListStyle.headerSummaryMaxLines,
                      style: articleListStyle.headerArticleSummaryStyle
                  )
                ],
              ),
            ),
            buildListSeparator()
          ],
        );
  }

  Widget buildListSeparator({ArticleListStyle articleListStyle = const _ArticleListDefaultStyle()}) {
    return Container(
        height: articleListStyle.separatorHeight,
        color: articleListStyle.separatorColor,
        margin: articleListStyle.separatorIndentation
    );
  }

  Widget _buildArticlesList(List<ArticleEntity> articlesList, Function getRelatedArticles, ArticleListStyle articleListStyle) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: articlesList.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _heroListItemBuilder(articlesList[index], articleListStyle);
          } else {
            return ArticleListItem().standardListItemBuilder(articlesList[index], getRelatedArticles);
          }
        });
  }

  Widget _buildHeaderArticleImage(ArticleEntity articleData, ArticleListStyle articleListStyle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(articleListStyle.headerImageBorderRadius),
      child: NetworkImageFromFuture(articleData.imageUrl, fit: BoxFit.fitWidth),
    );
  }
