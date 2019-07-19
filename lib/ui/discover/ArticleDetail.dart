import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
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

class ArticleDetail extends StatelessWidget implements ListViewSection {
  final ArticleDetailViewModel _viewModel;
  final ArticleDetailStyle _style;
  final bool _showHeader;
  List<ArticleListItemViewModel> _relatedViewModels  = [];

  ArticleDetail(
      {Key key,
      ArticleDetailViewModel viewModel, bool showHeader = true,
      ArticleDetailStyle style = const _DefaultStyle()})
      : this._viewModel = viewModel,
        this._showHeader = showHeader,
        this._style = style,
        super(key: key);

  Future<List<ArticleListItemViewModel>> fetchReleated() {
     return _viewModel.getRelated().then((related) {
       _relatedViewModels = related;
       return related;
     });
  }

  @override
  Widget build(BuildContext context) {
    final related = (_relatedViewModels != null) ? Future.value(_relatedViewModels) : fetchReleated();
    return FutureBuilder(
      future: related,
      builder: (BuildContext context,
          AsyncSnapshot<List<ArticleListItemViewModel>> relatedArticles) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
            child: _content(),
          ),
        );
      },
    );
  }

  HeaderAndFooterListView _content() {
     final loadingWidget = Container(
        child: CircularProgressIndicator(), alignment: Alignment.center);
    final footer = (_viewModel.loadingStatus == LoadingStatus.LOADING)
            ? loadingWidget
            : null;
      return HeaderAndFooterListView(
                itemCount: _relatedViewModels.length,
                itemBuilder: (BuildContext context, int index) {
                  final viewModel = _relatedViewModels[index];
                  return StandardListItem(
                    viewModel: viewModel,
                    onTap: () => _tappedListItem(
                        context: context, viewModel: viewModel.detailViewModel),
                  ).build(context);
                },
                physics: ScrollPhysics(),
                shrinkWrap: true,
                headers: [buildHeader(_relatedViewModels.isNotEmpty)],
                footers: [footer]);
  } 

  @override
  itemBuilder() {
    return _content().itemBuilder();
  }

  @override
  int length() {
    return _content().length();
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

  Widget buildHeader(bool relatedTitle) {
    final topWidgets = [
      _buildTitle(),
      _buildArticlePublishingDate(),
      SizedBox(height: _style.spaceBetweenDataAndImage),
      _buildImage(),
      SizedBox(height: _style.spaceBetweenElements),
      _buildBody(),
      SizedBox(height: _style.spaceBetweenElements),
    ];
    final midWidgets = [
      Container(
        padding: _style.titlePagePadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_viewModel.relatedTitle, style: _style.titlePageStyle)
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
    return Visibility(visible: _viewModel.title.isNotEmpty && _showHeader, child: Container(
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
        )));
  }

  Widget _buildArticlePublishingDate() {
    return Visibility(visible: _viewModel.subtitle.isNotEmpty && _showHeader, child: Container(
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
        )));
  }

  Widget _buildImage() {
    if (_viewModel.image == null) {
      return  Container();
    }
    return NetworkImageFromFuture(
            _viewModel.image.urlToFit(height: _style.imageHeight),
            fit: BoxFit.cover,
            height: _style.imageHeight);
  }

  Widget _buildBody() {
    return Container(
        padding: _style.bodyPadding,
        child: Html(data: _viewModel.body, useRichText: true));
  }
}
