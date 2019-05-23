import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import '../app_bar.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';


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
              _buildBody(context, viewModel.selectedArticle),
          converter: (store) => DiscoverViewModel.fromStore(store)),
    );
  }

  Widget _buildBody(BuildContext context, ArticleEntity selectedArticleData) {
    return Scaffold(
          appBar: CustomAppBar.buildForArticleDetail(selectedArticleData.title, CustomAppBar.shareAction(selectedArticleData.id)),
          body : Container(

              child: ListView(children: <Widget>[
                FadeInImage.assetNetwork(
                    image: selectedArticleData.imageUrl,
                    height: listImageHeight,
                    width: listImageWidth,
                    placeholder: Assets.IMAGE_PLACE_HOLDER,
                    fit: BoxFit.cover),
                Padding(
                    padding: Paddings.boxBigPadding(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Html(data: selectedArticleData.content),
                      ],
                    )),
              ]))
      );
  }
}

