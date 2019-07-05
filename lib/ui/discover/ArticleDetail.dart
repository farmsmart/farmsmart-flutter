import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleListItemViewModel.dart';
import 'package:farmsmart_flutter/ui/discover/StandardListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';

class _Strings {
  static const String shareText =
      "Check out this article from the FarmSmart mobile app \n ";
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
  final double imageHeight;

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
      this.imageHeight,
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
  final double imageHeight = 192;

  final int maxLinesPerTitle = 2;

  const _DefaultStyle();
}

class ArticleDetail extends StatelessWidget {
  final ArticleDetailViewModel _viewModel;
  final ArticleDetailStyle _style;

  const ArticleDetail(
      {Key key,
      ArticleDetailViewModel viewModel,
      ArticleDetailStyle style = const _DefaultStyle()})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _build(context: context, viewModel: _viewModel, style: _style);
  }

  Widget _build(
      {BuildContext context,
      ArticleDetailViewModel viewModel,
      ArticleDetailStyle style}) {
    var releatedViewModels = [];
    final loadingWidget = Container(
        child: CircularProgressIndicator(), alignment: Alignment.center);

    return FutureBuilder(
      future: viewModel.getRelated(),
      builder: (BuildContext context,
          AsyncSnapshot<List<ArticleListItemViewModel>> relatedArticles) {
        if (relatedArticles.hasData) {
          releatedViewModels = relatedArticles.data;
        }
        final footer = (viewModel.loadingStatus == LoadingStatus.LOADING)
            ? loadingWidget
            : null;
        return Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
            child: HeaderAndFooterListView.builder(
                itemCount: releatedViewModels.length,
                itemBuilder: (BuildContext context, int index) {
                  final viewModel = releatedViewModels[index];
                  return StandardListItem(
                    viewModel: viewModel,
                    onTap: () => _tappedListItem(
                        context: context, viewModel: viewModel.detailViewModel),
                  ).build(context);
                },
                physics: ScrollPhysics(),
                shrinkWrap: true,
                header: _buildHeader(
                    context, releatedViewModels.isNotEmpty, viewModel, style),
                footer: footer),
          ),
        );
      },
    );
  }

  void _share() async {
    final link = await _viewModel.shareLink;
    await Share.share(_Strings.shareText + link);
  }

  Widget _buildAppBar(BuildContext context) {
    return ContextualAppBar(
      shareAction: _share,
    ).build(context);
  }

  Widget _buildHeader(BuildContext context, bool relatedTitle,
      ArticleDetailViewModel viewModel, ArticleDetailStyle style) {
    final topWidgets = [
      _buildTitle(),
      _buildArticlePublishingDate(),
      SizedBox(height: style.spaceBetweenDataAndImage),
      _buildImage(),
      SizedBox(height: style.spaceBetweenElements),
      _buildBody(),
      SizedBox(height: style.spaceBetweenElements),
    ];
    final midWidgets = [
      Container(
        padding: style.titlePagePadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_viewModel.relatedTitle, style: style.titlePageStyle)
          ],
        ),
      ),
    ];
    final headerWidgets = relatedTitle ? topWidgets + midWidgets : topWidgets;
    return Column(
      children: headerWidgets,
    );
  }

  void _tappedListItem(
      {BuildContext context, ArticleDetailViewModel viewModel}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArticleDetail(viewModel: viewModel),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
        padding: _style.titlePagePadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                _viewModel.title,
                style: _style.titlePageStyle,
                maxLines: _style.maxLinesPerTitle,
              ),
            )
          ],
        ));
  }

  Widget _buildArticlePublishingDate() {
    return Container(
        padding: _style.leftRightPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                _viewModel.subtitle,
                style: _style.dateStyle,
              ),
            )
          ],
        ));
  }

  Widget _buildImage() {
    return Container(
        child: NetworkImageFromFuture(
            _viewModel.image.urlToFit(height: _style.imageHeight),
            fit: BoxFit.cover,
            height: _style.imageHeight));
  }

  Widget _buildBody() {
    return Container(
        padding: _style.bodyPadding,
        child: Html(data: _viewModel.body, useRichText: true));
  }
}
