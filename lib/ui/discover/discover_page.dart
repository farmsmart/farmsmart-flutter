import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/discover/HeroListItem.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/discover/StandardListItem.dart';
import 'package:farmsmart_flutter/ui/discover/discover_viewmodel.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';

class ArticleListItemViewModel {
  final String title;
  final String summary;
  final Future<String> imageUrl;
  Function onTap;

  ArticleListItemViewModel(this.title, this.summary, this.imageUrl, this.onTap);
}

ArticleListItemViewModel fromArticleEntityToViewModel(ArticleEntity article, Function getRelatedArticles) {
  return ArticleListItemViewModel(
      article.title ?? Strings.noTitleString,
      article.summary ?? Strings.noTitleString,
      article.imageUrl,
      () => getRelatedArticles(article));
}

abstract class ArticleListStyle {
  final TextStyle titleTextStyle;
  final EdgeInsets titleEdgePadding;

  ArticleListStyle(this.titleTextStyle, this.titleEdgePadding);
}

class _ArticleListDefaultStyle implements ArticleListStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color textColor = Color(0xFF767690);

  final TextStyle titleTextStyle = const TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: titleColor);
  final EdgeInsets titleEdgePadding = const EdgeInsets.only(left: 34.0, right: 34.0, top: 35.0, bottom: 30.0);

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
        return Container(child: CircularProgressIndicator(), alignment: Alignment.center);
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
    padding: articleListStyle.titleEdgePadding,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(Strings.discoverTab, style: articleListStyle.titleTextStyle)
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
          return HeroListItem().builder(fromArticleEntityToViewModel(articlesList[index], getRelatedArticles));
        } else {
          return StandardListItem().builder(fromArticleEntityToViewModel(articlesList[index], getRelatedArticles));
        }
      });
}



// TODO: Maybe we have to externalice this widget in other file
abstract class DividerStyle {
  final Color color;
  final EdgeInsets indentation;
  final double height;

  DividerStyle(this.color, this.indentation, this.height);
}

class DefaultDividerStyle implements DividerStyle {
  final Color color = const Color(0xFFf5f8fa);
  final EdgeInsets indentation = const EdgeInsets.only(left: 32.0);
  final double height = 2.0;

  const DefaultDividerStyle();
}

Widget buildListDivider({DividerStyle dividerStyle = const DefaultDividerStyle()}) {
  return Container(
      height: dividerStyle.height,
      color: dividerStyle.color,
      margin: dividerStyle.indentation);
}
