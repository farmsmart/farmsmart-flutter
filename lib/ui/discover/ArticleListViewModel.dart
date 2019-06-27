import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:redux/redux.dart';

class ArticleListItemViewModel {
  final String title;
  final String summary;
  final Future<String> imageUrl;
  Function onTap;

  ArticleListItemViewModel(this.title, this.summary, this.imageUrl, this.onTap);
}

class ArticleListViewModel {
  final LoadingStatus loadingStatus;
  final List<ArticleListItemViewModel> articleListItemViewModels;

  ArticleListViewModel(
      {List<ArticleEntity> articleItems, LoadingStatus loadingStatus})
      : this.loadingStatus = loadingStatus,
        this.articleListItemViewModels = articleItems
            .map((entity) => fromArticleEntityToViewModel(entity, null)).toList();

  static ArticleListViewModel fromStore(Store<AppState> store) {
    return ArticleListViewModel(
        loadingStatus: store.state.discoverState.loadingStatus,
        articleItems: store.state.discoverState.articles);
  }

  static ArticleListItemViewModel fromArticleEntityToViewModel(
      ArticleEntity article, Function viewArticle) {
    return ArticleListItemViewModel(
        article.title ?? Strings.noTitleString,
        article.summary ?? Strings.noTitleString,
        article.imageUrl,
        () => viewArticle(article));
  }
}
