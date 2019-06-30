import 'package:farmsmart_flutter/data/model/ImageEntity.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleDetail.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:redux/redux.dart';

class ArticleListItemViewModel {
  final String title;
  final String summary;
  final ImageEntityURLProvider image;
  Function onTap;

  ArticleListItemViewModel(this.title, this.summary, this.image, this.onTap);
}

class ArticleImageProvider implements ImageEntityURLProvider {
  final ArticleEntity _article;
  ArticleImageProvider(ArticleEntity article) : _article = article;
  @override
  Future<String> urlToFit({double width, double height}) {
    return _article.images.getEntities().then((imageEntities) {
      // NB: we assume the first image is the hero
      return imageEntities.first.urlProvider.urlToFit(width: width,height: height);
    });
  }
}

class ArticleListViewModel {
  final LoadingStatus loadingStatus;
  final List<ArticleListItemViewModel> articleListItemViewModels;

  ArticleListViewModel(
      {List<ArticleEntity> articleItems, LoadingStatus loadingStatus, Function onTap})
      : this.loadingStatus = loadingStatus,
        this.articleListItemViewModels = articleItems
            .map((entity) => fromArticleEntityToViewModel(entity, () => onTap(ArticleDetailViewModel.fromArticleEntityToViewModel(entity)))).toList();

  static ArticleListViewModel fromStore(Store<AppState> store, Function onTap) {
    return ArticleListViewModel(
        loadingStatus: store.state.discoverState.loadingStatus,
        articleItems: store.state.discoverState.articles, onTap: onTap);
  }

  static ArticleListItemViewModel fromArticleEntityToViewModel(
      ArticleEntity article, Function onTap) {
    return ArticleListItemViewModel(
        article.title ?? Strings.noTitleString,
        article.summary ?? Strings.noTitleString,
        ArticleImageProvider(article), onTap);
  }
}
