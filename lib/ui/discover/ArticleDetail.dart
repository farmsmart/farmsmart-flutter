import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/discover/StandardListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import '../app_bar.dart';
import 'ArticleListViewModel.dart';

abstract class ArticleDetailViewModel {
  final LoadingStatus loadingStatus;
  final String title;
  final String subtitle;
  final Future<String> imageUrl;
  final String body;
  Function shareAction;
  Future<List<ArticleListItemViewModel>> getRelated();
  /*
          String deepLink = await buildArticleDeeplink(articleID);
          var response = await FlutterShareMe().shareToSystem(msg: Strings.shareArticleText + deepLink);
  */
  static ArticleDetailViewModel fromStore(Store<AppState> store) {
    return null;
  }

  ArticleDetailViewModel(this.loadingStatus, this.title, this.subtitle, this.imageUrl,
      this.body, this.shareAction);
  
}

abstract class ArticleDetailStyle {
  final TextStyle titlePageStyle;
  final TextStyle dateStyle;
  final TextStyle bodyStyle;

  final EdgeInsets titlePagePadding;
  final EdgeInsets leftRightPadding;
  final EdgeInsets bodyPadding;

  final double spaceBetweenDataAndImage;
  final double spaceBetweenElements;

  final int maxLinesPerTitle;

  ArticleDetailStyle(
      this.titlePageStyle,
      this.dateStyle,
      this.bodyStyle,
      this.titlePagePadding,
      this.leftRightPadding,
      this.bodyPadding,
      this.spaceBetweenDataAndImage,
      this.spaceBetweenElements,
      this.maxLinesPerTitle);
}

class _DefaultStyle implements ArticleDetailStyle {
  static const Color titlesColor = Color(0xFF1a1b46);
  static const Color footColor = Color(0xFF767690);
  static const Color bodyColor = Color(0xFF4c4e6e);

  final TextStyle titlePageStyle = const TextStyle(
      fontSize: 27, fontWeight: FontWeight.bold, color: titlesColor);
  final TextStyle dateStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: footColor);
  final TextStyle bodyStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500, color: bodyColor);

  final EdgeInsets titlePagePadding =
      const EdgeInsets.only(left: 34.0, right: 34.0, top: 15.0, bottom: 20.0);
  final EdgeInsets leftRightPadding =
      const EdgeInsets.only(left: 32.0, right: 32.0);
  final EdgeInsets bodyPadding = const EdgeInsets.only(left: 32.5, right: 45.0);

  final double spaceBetweenDataAndImage = 36;
  final double spaceBetweenElements = 41;

  final int maxLinesPerTitle = 2;

  const _DefaultStyle();
}

class ArticleDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState extends State<ArticleDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, ArticleDetailViewModel>(
        builder: (_, viewModel) => _build(context, viewModel),
        converter: (store) => ArticleDetailViewModel.fromStore(store),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ArticleDetailViewModel viewModel, ArticleDetailStyle style) {
    return ListView(
        children: <Widget>[
          _buildTitle(viewModel.title, style),
          _buildArticlePublishingDate(viewModel, style),
          SizedBox(height: style.spaceBetweenDataAndImage),
          _buildImage(viewModel),
          SizedBox(height: style.spaceBetweenElements),
          _buildBody(viewModel, style),
          SizedBox(height: style.spaceBetweenElements),
                  ],
      );
  }

  Widget _build(BuildContext context, ArticleDetailViewModel viewModel,
      {ArticleDetailStyle style = const _DefaultStyle()}) {
        final releatedViewModels = [];
        final loadingWidget = Container(
            child: CircularProgressIndicator(), alignment: Alignment.center);
        final footer = (viewModel.loadingStatus == LoadingStatus.LOADING) ? loadingWidget : null; 
    return Scaffold(
        appBar: CustomAppBar.buildForArticleDetail(
            viewModel.title, CustomAppBar.shareAction(viewModel.shareAction)),
        body: HeaderAndFooterListView.builder(
        itemCount: releatedViewModels.length,
        itemBuilder: (BuildContext context, int index) {
          final viewModel = releatedViewModels[index];
            return StandardListItem().build(viewModel);
        },
        physics: ScrollPhysics(),
        shrinkWrap: true,
        header: _buildHeader(context, viewModel, style),
        footer: footer
        ));
  }

// FIXME: Reuse the _buildScreenTitle from discover page (don't need to redefine here)
  Widget _buildTitle(
      String selectedArticleTitle, ArticleDetailStyle articleStyle) {
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

  Widget _buildArticlePublishingDate(
      ArticleDetailViewModel viewModel, ArticleDetailStyle style) {
    return Container(
        padding: style.leftRightPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                viewModel.subtitle,
                style: style.dateStyle,
              ),
            )
          ],
        ));
  }

  Widget _buildImage(ArticleDetailViewModel selectedArticle) {
    return Container(
        child: NetworkImageFromFuture(selectedArticle.imageUrl,
            fit: BoxFit.cover, height: 192.0));
  }

//TODO: Investigate how to add style to Html elements
  Widget _buildBody(
      ArticleDetailViewModel selectedArticle, ArticleDetailStyle articleStyle) {
    return Container(
        padding: articleStyle.bodyPadding,
        child: Html(data: selectedArticle.body, useRichText: true));
  }

}
