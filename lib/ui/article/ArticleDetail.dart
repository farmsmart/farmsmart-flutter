import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:farmsmart_flutter/ui/common/SectionListView.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/image_provider_view.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';
import 'package:farmsmart_flutter/ui/article/StandardListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class _LocalisedStrings {
  static String shareText() =>
      Intl.message('Check out this article from the FarmSmart mobile app \n ');

  static String viewMore() => Intl.message('View more on the web');
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
  final EdgeInsets bodyPadding = const EdgeInsets.only(left: 32.0, right: 32.0);

  final double spaceBetweenDataAndImage = 36;
  final double spaceBetweenElements = 41;
  final double imageHeight = 192;

  final int maxLinesPerTitle = 2;

  const _DefaultStyle();
}

class ArticleDetail extends StatelessWidget implements ListViewSection {
  final ArticleDetailViewModel _viewModel;
  final ArticleDetailStyle _style;
  final Widget _articleHeader;
  final Widget _articleFooter;
  List<ArticleListItemViewModel> _relatedViewModels = [];

  ArticleDetail(
      {Key key,
      ArticleDetailViewModel viewModel,
      ArticleDetailStyle style = const _DefaultStyle(),
      Widget articleHeader,
      Widget articleFooter})
      : this._viewModel = viewModel,
        this._articleHeader = articleHeader,
        this._articleFooter = articleFooter,
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
    final related =
        _hasRelated() ? Future.value(_relatedViewModels) : fetchReleated();
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

  bool _hasRelated() {
    return ((_relatedViewModels != null) && (_relatedViewModels.isNotEmpty));
  }

  Widget _relatedHeader() {
    return Container(
      padding: _style.titlePagePadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_viewModel.relatedTitle ?? "", style: _style.titlePageStyle)
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }

    //TODO: LH add error popp up (when we have the widget)
  }

  Widget _externLinkSection() {
    final buttonViewModel = RoundedButtonViewModel(
        title: _viewModel.contentLinkTitle ?? _LocalisedStrings.viewMore(),
        onTap: () {
          _launchURL(_viewModel.contentLink);
        });
    return Padding(
      padding: _style.bodyPadding,
      child: RoundedButton(
        viewModel: buttonViewModel,
        style: RoundedButtonStyle.actionSheetLargeRoundedButton(),
      ),
    );
  }

  HeaderAndFooterListView _content() {
    final List<Widget> relatedTitle = _hasRelated() ? [_relatedHeader()] : [];
    final List<Widget> contentLink =
        (_viewModel.contentLink != null) ? [_externLinkSection()] : [];

    final List<Widget> articleHeaders =
        (_articleHeader != null) ? [_articleHeader] : [_buildDefaultHeader()];
    final List<Widget> articleFooters =
        (_articleFooter != null) ? [_articleFooter] : [];

    final headers = articleHeaders +
        [buildArticle()] +
        contentLink +
        articleFooters +
        relatedTitle;

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
      headers: headers,
    );
  }

  @override
  itemBuilder() {
    return _content().itemBuilder();
  }

  @override
  int itemCount() {
    return _content().itemCount();
  }

  void _share() async {
    final link = await _viewModel.shareLink;
    await Share.share(_LocalisedStrings.shareText() + link);
  }

  Widget _buildAppBar(BuildContext context) {
    return ContextualAppBar(
      shareAction: _share,
    ).build(context);
  }

  Widget _buildDefaultHeader() {
    final List<Widget> titleSection =
        (_viewModel.title.isNotEmpty) ? [_buildTitle()] : [];
    final List<Widget> subtitleSection =
        (_viewModel.subtitle.isNotEmpty) ? [_buildSubtitle()] : [];
    final List<Widget> headerWidgets = titleSection + subtitleSection;
    return Column(
      children: headerWidgets,
    );
  }

  Widget buildArticle() {
    final image = _buildImage();
    final body = _buildBody();
    final List<Widget> imageSection = image != null
        ? [
            SizedBox(height: _style.spaceBetweenElements),
            image,
            SizedBox(height: _style.spaceBetweenElements)
          ]
        : [];
    final List<Widget> bodySection = body != null
        ? [
            SizedBox(height: _style.spaceBetweenDataAndImage),
            body,
            SizedBox(height: _style.spaceBetweenElements)
          ]
        : [SizedBox(height: _style.spaceBetweenElements)];
    final List<Widget> articleWidgets = imageSection + bodySection;
    return Column(
      children: articleWidgets,
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

  Widget _buildSubtitle() {
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
    if (_viewModel.image == null) {
      return null;
    }
    return ImageProviderView(
        imageURLProvider: _viewModel.image, height: _style.imageHeight);
  }

  Widget _buildBody() {
    return Container(
        padding: _style.bodyPadding,
        child: Html(data: _viewModel.body, useRichText: true));
  }
}
