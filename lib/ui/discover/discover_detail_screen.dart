import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:farmsmart_flutter/ui/common/content_webview.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/common/related_article.dart';
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

  GlobalKey<State<Scaffold>> scaffold = GlobalKey<State<Scaffold>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, DiscoverViewModel>(
        builder: (_, viewModel) => _buildBody(context, viewModel),
        converter: (store) => DiscoverViewModel.fromStore(store),
      ),
    );
  }

  //Widget _buildList(BuildContext context, ArticleEntity selectedArticle, getRelatedArticles) {
  Widget _buildBody(BuildContext context, DiscoverViewModel viewModel) {
    switch (viewModel.loadingStatus) {
      case LoadingStatus.LOADING:
        return Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
      case LoadingStatus.SUCCESS:
        return _buildList(context, viewModel.selectedArticleWithRelated,
            viewModel.getRelatedArticles);
      case LoadingStatus.ERROR:
        return Text("Error"); // TODO Check FARM-203
    }
  }

  Widget _buildList(
      BuildContext context, ArticleEntity selectedArticle, Function getRelatedArticles) {
    return Scaffold(
      key : scaffold,
        appBar: CustomAppBar.buildForDetail(selectedArticle.title),
        persistentFooterButtons: RelatedArticle.buildRelatedArticlesFooter(scaffold, selectedArticle, getRelatedArticles),
        body: Container(
            child: ContentWebView(htmlContent : selectedArticle.content),
        )
    );
  }
}


