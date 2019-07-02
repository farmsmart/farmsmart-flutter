import 'package:farmsmart_flutter/data/model/ImageEntity.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/discover/StandardListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'ArticleListViewModel.dart';

typedef GetList<T> = Future<List<T>> Function();

class ArticleDetailViewModel {
  final LoadingStatus loadingStatus;
  final String title;
  final String subtitle;
  final ImageEntityURLProvider image;
  final String body;
  Function shareAction;
  GetList<ArticleListItemViewModel> getRelated;
  /*
          String deepLink = await buildArticleDeeplink(articleID);
          var response = await FlutterShareMe().shareToSystem(msg: Strings.shareArticleText + deepLink);
  */

  ArticleDetailViewModel(this.loadingStatus, this.title, this.subtitle,
      this.image, this.body, this.shareAction);

  static ArticleDetailViewModel fromArticleEntityToViewModel(
      ArticleEntity article) {
    ArticleDetailViewModel viewModel = ArticleDetailViewModel(
        LoadingStatus.SUCCESS,
        article.title,
        article.summary,
        ArticleImageProvider(article),
        article.content,
        null);
    if (article.related != null) {
      viewModel.getRelated = () {
        if (article.related == null) {
          return Future.value([]);
        }
        return article.related.getEntities().then((articles) {
          return articles.map((article) {
            return ArticleListItemViewModel.fromArticleEntityToViewModel(
                article: article);
          }).toList();
        });
      };
    }
    return viewModel;
  }
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
  final ArticleDetailViewModel _viewModel;

  const ArticleDetail({Key key, ArticleDetailViewModel viewModel})
      : this._viewModel = viewModel,
        super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState(_viewModel);
  }
}

class _ArticleDetailState extends State<ArticleDetail> {
  final ArticleDetailViewModel _viewModel;

  _ArticleDetailState(ArticleDetailViewModel viewModel)
      : this._viewModel = viewModel;

  @override
  Widget build(BuildContext context) {
    return _build(context, _viewModel);
  }

  Widget _buildHeader(BuildContext context, ArticleDetailViewModel viewModel,
      ArticleDetailStyle style) {
    return Column(
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

  void _tappedListItem({BuildContext context, ArticleDetailViewModel viewModel}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArticleDetail(viewModel: viewModel),
      ),
    );
  }

  Widget _build(BuildContext context, ArticleDetailViewModel viewModel,
      {ArticleDetailStyle style = const _DefaultStyle()}) {
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
          appBar: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
          ),
          body: Container(
            child: HeaderAndFooterListView.builder(
                itemCount: releatedViewModels.length,
                itemBuilder: (BuildContext context, int index) {
                  final viewModel = releatedViewModels[index];
                  return StandardListItem(viewModel: viewModel, onTap: () => _tappedListItem(context: context, viewModel: viewModel.detailViewModel),).build(context);
                },
                physics: ScrollPhysics(),
                shrinkWrap: true,
                header: _buildHeader(context, viewModel, style),
                footer: footer),
          ),
        );
        ;
      },
    );
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

  Widget _buildImage(ArticleDetailViewModel viewModel) {
    return Container(
        child: NetworkImageFromFuture(viewModel.image.urlToFit(height: 192.0),
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
