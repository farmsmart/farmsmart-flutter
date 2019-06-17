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

class ArticlesListViewModel {
  final String title;
  final String summary;
  final Future<String> imageUrl;

  ArticlesListViewModel(this.title, this.summary, this.imageUrl);
}

ArticlesListViewModel fromArticleEntityToViewModel(ArticleEntity currentArticle) {
  return ArticlesListViewModel(currentArticle.title, currentArticle.summary, currentArticle.imageUrl);
}

abstract class ArticleListStyle {
  final TextStyle titlePageStyle;
  final TextStyle heroTitleTextStyle;
  final TextStyle heroSummaryTextStyle;

  final EdgeInsets titlePagePadding;
  final EdgeInsets heroPadding;

  final double heroImageBorderRadius;
  final double spaceBetweenHeaderImageAndText;
  final double spaceBetweenTitleAndSummary;
  final double heroCardElevation;

  final int heroTitleMaxLines;
  final int heroSummaryMaxLines;

  final CrossAxisAlignment leftAlignmentHorizontal;
  final MainAxisAlignment centerAlignmentVertical;

  ArticleListStyle(this.titlePageStyle, this.heroTitleTextStyle,
      this.heroSummaryTextStyle, this.titlePagePadding,
      this.heroPadding, this.heroImageBorderRadius,
      this.spaceBetweenHeaderImageAndText, this.spaceBetweenTitleAndSummary,
      this.heroCardElevation, this.heroTitleMaxLines, this.heroSummaryMaxLines,
      this.leftAlignmentHorizontal, this.centerAlignmentVertical);
}

class _ArticleListDefaultStyle implements ArticleListStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color bodyColor = Color(0xFF767690);

  final TextStyle titlePageStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: titleColor);
  final TextStyle heroTitleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: titleColor);
  final TextStyle heroSummaryTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: bodyColor);

  final EdgeInsets titlePagePadding = const EdgeInsets.only(left: 34.0, right: 34.0, top: 35.0, bottom: 30.0);
  final EdgeInsets heroPadding = const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 28);

  final double heroImageBorderRadius = 14.0;
  final double spaceBetweenHeaderImageAndText = 22.0;
  final double spaceBetweenTitleAndSummary = 9.5;
  final double heroCardElevation = 0;

  final int heroTitleMaxLines = 1;
  final int heroSummaryMaxLines = 3;

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

Widget _heroListItemBuilder(ArticleEntity firstArticle, ArticleListStyle articleListStyle, Function getRelatedArticles) {
  return GestureDetector(
    onTap: () => getRelatedArticles(firstArticle),
    child: Column(
      children: <Widget>[
        Card(
          elevation: articleListStyle.heroCardElevation,
          child: Container(
            padding: articleListStyle.heroPadding,
            child: Column(
              crossAxisAlignment: articleListStyle.leftAlignmentHorizontal,
              children: <Widget>[
                _buildHeroArticleImage(firstArticle, articleListStyle),
                SizedBox(height: articleListStyle.spaceBetweenHeaderImageAndText),
                Text(firstArticle.title,
                    maxLines: articleListStyle.heroTitleMaxLines,
                    style: articleListStyle.heroTitleTextStyle),
                SizedBox(height: articleListStyle.spaceBetweenTitleAndSummary),
                Text(firstArticle.summary,
                    maxLines: articleListStyle.heroSummaryMaxLines,
                    style: articleListStyle.heroSummaryTextStyle)
              ],
            ),
          ),
        ),
        buildListDivider()
      ],
    ),
  );
}

Widget _buildArticlesList(List<ArticleEntity> articlesList, Function getRelatedArticles, ArticleListStyle articleListStyle) {
  return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: articlesList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _heroListItemBuilder(articlesList[index], articleListStyle, getRelatedArticles);
        } else {
          return ArticleListItem().standardListItemBuilder(fromArticleEntityToViewModel(articlesList[index]), getRelatedArticles);
        }
      });
}

Widget _buildHeroArticleImage(ArticleEntity articleData, ArticleListStyle articleListStyle) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(articleListStyle.heroImageBorderRadius),
    child: NetworkImageFromFuture(articleData.imageUrl, fit: BoxFit.fitWidth),
  );
}

abstract class SeparatorStyle {
  final Color color;
  final EdgeInsets indentation;
  final double height;

  SeparatorStyle(this.color, this.indentation, this.height);
}

class DefaultSeparatorStyle implements SeparatorStyle {
  final Color color = const Color(0xFFf5f8fa);
  final EdgeInsets indentation = const EdgeInsets.only(left: 32.0);
  final double height = 2.0;

  const DefaultSeparatorStyle();
}

Widget buildListDivider({SeparatorStyle separatorStyle = const DefaultSeparatorStyle()}) {
  return Container(
      height: separatorStyle.height,
      color: separatorStyle.color,
      margin: separatorStyle.indentation);
}
