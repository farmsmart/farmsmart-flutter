import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import '../app_bar.dart';

import 'discover_child_item.dart';
import 'discover_viewmodel.dart';

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
          builder: (_, viewModel) =>
              _buildList(context, viewModel.selectedArticleWithRelated, viewModel.getRelatedArticles),
          converter: (store) => DiscoverViewModel.fromStore(store)),
    );
  }
  Widget _buildList(BuildContext context, ArticleEntity selectedArticle, getRelatedArticles) {
    return Scaffold(
        appBar: CustomAppBar.buildForDetail(selectedArticle.title),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInImage.assetNetwork(
                    image: selectedArticle.imageUrl,
                    height: listImageHeight,
                    width: listImageWidth,
                    placeholder: Assets.IMAGE_PLACE_HOLDER,
                    fit: BoxFit.cover),
                Padding(
                    padding: Paddings.boxSmallPadding(),
                    child: Text(selectedArticle.title,
                        style: Styles.detailTitleTextStyle())),
                Padding(
                    padding: Paddings.boxSmallPadding(),
                    child: Html(data: selectedArticle.content)),
                buildRelated(context, selectedArticle.relatedArticles, getRelatedArticles),
              ],
            )));
  }
}


Widget buildRelated(BuildContext context, List<ArticleEntity> articlesList, getRelatedArticles) {
  return Column(
      //padding: const EdgeInsets.only(top: 20.0),
      children: (articlesList != null) ? (articlesList.map((article) =>
          buildListOfRelatedArticles(article, getRelatedArticles)).toList()) : null);
}

Widget buildListOfRelatedArticles(ArticleEntity articleData, getRelatedArticles) {
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
                _buildDividerLine()
              ],
            )),
      ));
}


_buildListItemImage(ArticleEntity articleData) {
  return FadeInImage.assetNetwork(
      image: articleData.imageUrl,
      placeholder: Assets.IMAGE_PLACE_HOLDER,
      height: 90,
      width: 140,
      fit: BoxFit.cover);
}

_buildArticleTitle(ArticleEntity articleData) {
  return Expanded(
    flex: 6,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(articleData.title ?? Strings.noTitleString,
            style: Styles.articleListTitleStyle()),
        Margins.generalListSmallerMargin(),
        Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Styles.footerTextStyle()),
      ],
    ),
  );
}

_buildListIcon() {
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

_buildDividerLine() {
  return Divider(
    height: 1,
    color: Color(black),
    indent: 145,
  );
}

