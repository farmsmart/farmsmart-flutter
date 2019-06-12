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

class HomeDiscoverPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _DiscoveryState();
  }
}

class _DiscoveryState extends State<HomeDiscoverPage> {

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
        return _buildDiscoverPage(context, viewModel.articleDirectory.articles,
            viewModel.getRelatedArticles);
      case LoadingStatus.ERROR:
        return Text(Strings.errorString);
    }
  }

  Widget _buildDiscoverPage(BuildContext context,
      List<ArticleEntity> articlesList, Function getRelatedArticles) {
    return ListView(
      children: <Widget>[
        _buildTitle(),
        _buildHeadArticle(articlesList.first),
        _buildList(articlesList, getRelatedArticles)
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            Strings.discoverTab,
            style: Styles.titleTextStyle(),
          )
        ],
      ),
    );
  }

  Widget _buildHeadArticle(ArticleEntity firstArticle) {
    return Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(child: buildListItemImage(firstArticle)),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 18.0)),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                              firstArticle.title,
                              style: Styles.articleListTitleStyle())
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0)),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                              firstArticle.summary,
                              maxLines: 3,
                              style: Styles.articleSummaryTextStyle()))
                    ],
                  ),
                ],
              ),
            ),
            Dividers.listDividerLine()
          ],
        ));
  }

  Widget _buildList(
      List<ArticleEntity> articlesList, Function getRelatedArticles) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: articlesList.length-1,
        itemBuilder: (BuildContext context, int index) {
          return DiscoveryListItem()
              .buildListItem(articlesList[index+1], getRelatedArticles);
        });
  }

  buildListItemImage(ArticleEntity articleData) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: NetworkImageFromFuture(articleData.imageUrl, fit: BoxFit.fitWidth),
    );
  }
}
