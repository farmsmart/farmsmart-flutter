import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:redux/redux.dart';

class DiscoverViewModel {
  LoadingStatus loadingStatus;
  final List<ArticleEntity> articlesList;
  final ArticleEntity selectedArticle;

  final Function fetchArticles;
  final Function(ArticleEntity articleData) goToArticleDetail;

  DiscoverViewModel(
      {this.loadingStatus,
      this.articlesList,
      this.selectedArticle,
      this.fetchArticles,
      this.goToArticleDetail});

  static DiscoverViewModel fromStore(Store<AppState> store) {
    return DiscoverViewModel(
      loadingStatus:  store.state.discoverState.loadingStatus,
      articlesList: store.state.discoverState.articleList,
      selectedArticle: store.state.discoverState.selectedArticle,
      goToArticleDetail: (ArticleEntity article) => store.dispatch(GoToArticleDetailAction(article)),
      fetchArticles: () =>
          store.dispatch(new FetchArticleListAction())
    );
  }
}
