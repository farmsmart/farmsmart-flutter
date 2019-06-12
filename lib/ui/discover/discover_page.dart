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

abstract class HomeDiscoverPageStyle {
  final Color separatorColor;

  final TextStyle titlePageStyle;
  final TextStyle titleArticleStyle;
  final TextStyle summaryArticleStyle;

  final EdgeInsets titlePadding;
  final EdgeInsets headerArticlePadding;
  final EdgeInsets itemListPadding;
  final EdgeInsets separatorIndentation;

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

  HomeDiscoverPageStyle(this.separatorColor, this.titlePageStyle,
      this.titleArticleStyle, this.summaryArticleStyle, this.titlePadding,
      this.headerArticlePadding, this.itemListPadding,
      this.separatorIndentation, this.separatorHeight,
      this.headerImageBorderRadius, this.itemImageBorderRadius,
      this.itemImageSize, this.spaceBetweenHeaderImageAndText,
      this.spaceBetweenTitleAndSummary, this.spaceBetweenItemTextAndImage,
      this.maxLinesPerTitle, this.maxLinesPerSummary, this.headerTitleMaxLines,
      this.headerSummaryMaxLines, this.leftAlignmentHorizontal,
      this.centerAlignmentVertical);
}

class _DiscoverDefaultStyle implements HomeDiscoverPageStyle {
  static const Color titlesColor = Color(0xFF1a1b46);
  static const Color bodyColor = Color(0xFF767690);
  final Color separatorColor = const Color(0xFFf5f8fa);

  final TextStyle titlePageStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: titlesColor);
  final TextStyle titleArticleStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: titlesColor);
  final TextStyle summaryArticleStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: bodyColor);

  final EdgeInsets titlePadding = const EdgeInsets.only(left: 34.0, right: 34.0, top: 35.0, bottom: 30.0);
  final EdgeInsets headerArticlePadding = const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 28);
  final EdgeInsets itemListPadding = const EdgeInsets.only(left: 32.0, right: 32.0, top: 23, bottom: 23);
  final EdgeInsets separatorIndentation = const EdgeInsets.only(left: 32.0);

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

  const _DiscoverDefaultStyle();
}


class HomeDiscoverPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _DiscoveryState();
  }
}

class _DiscoveryState extends State<HomeDiscoverPage> {

  @override
  Widget build(BuildContext context, {HomeDiscoverPageStyle discoverStyle = const _DiscoverDefaultStyle()}) {
    return Scaffold(
      body: StoreConnector<AppState, DiscoverViewModel>(
          onInit: (store) => store.dispatch(new FetchArticleDirectoryAction()),
          builder: (_, viewModel) => _buildBody(context, viewModel, discoverStyle),
          converter: (store) => DiscoverViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, DiscoverViewModel viewModel, HomeDiscoverPageStyle discoverStyle) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildDiscoverPage(context, viewModel.articleDirectory.articles,
            viewModel.getRelatedArticles, discoverStyle);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }
}

  Widget _buildDiscoverPage(BuildContext context, List<ArticleEntity> articlesList, Function getRelatedArticles, HomeDiscoverPageStyle discoverStyle) {
    return ListView(
      children: <Widget>[
        _buildScreenTitle(discoverStyle),
        _buildHeaderArticle(articlesList.first, discoverStyle),
        _buildArticlesList(articlesList, getRelatedArticles, discoverStyle)
      ],
    );
  }

  Widget _buildScreenTitle(HomeDiscoverPageStyle discoverStyle) {
    return Container(
      padding: discoverStyle.titlePadding,
      child: Row(
        crossAxisAlignment: discoverStyle.leftAlignmentHorizontal,
        children: <Widget>[
          Text(Strings.discoverTab, style: discoverStyle.titlePageStyle)
        ],
      ),
    );
  }

  Widget _buildHeaderArticle(ArticleEntity firstArticle, HomeDiscoverPageStyle discoverStyle) {
    return Column(
          children: <Widget>[
            Container(
              padding: discoverStyle.headerArticlePadding,
              child: Column(
                crossAxisAlignment: discoverStyle.leftAlignmentHorizontal,
                children: <Widget>[
                  _buildHeaderArticleImage(firstArticle, discoverStyle),
                  SizedBox(height: discoverStyle.spaceBetweenHeaderImageAndText),
                  Text(
                      firstArticle.title,
                      maxLines: discoverStyle.headerTitleMaxLines,
                      style: discoverStyle.titleArticleStyle
                  ),
                  SizedBox(height: discoverStyle.spaceBetweenTitleAndSummary),
                  Text(
                      firstArticle.summary,
                      maxLines: discoverStyle.headerSummaryMaxLines,
                      style: discoverStyle.summaryArticleStyle
                  )
                ],
              ),
            ),
            buildListSeparator(discoverStyle)
          ],
        );
  }

  Widget buildListSeparator(HomeDiscoverPageStyle discoverStyle) {
    return Container(
        height: discoverStyle.separatorHeight,
        color: discoverStyle.separatorColor,
        margin: discoverStyle.separatorIndentation
    );
  }

  Widget _buildArticlesList(List<ArticleEntity> articlesList, Function getRelatedArticles, HomeDiscoverPageStyle discoverStyle) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: articlesList.length-1,
        itemBuilder: (BuildContext context, int index) {
          return DiscoveryListItem().buildListItem(articlesList[index+1], getRelatedArticles, discoverStyle);
        });
  }

  Widget _buildHeaderArticleImage(ArticleEntity articleData, HomeDiscoverPageStyle discoverStyle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(discoverStyle.headerImageBorderRadius),
      child: NetworkImageFromFuture(articleData.imageUrl, fit: BoxFit.fitWidth),
    );
  }
