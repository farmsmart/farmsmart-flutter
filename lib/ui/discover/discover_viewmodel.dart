import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:redux/redux.dart';

class DiscoverViewModel {
  LoadingStatus loadingStatus;
  final ArticlesDirectoryEntity articleDirectory;
  final ArticleEntity selectedArticle;

  final Function fetchArticleDirectory;
  final Function(ArticleEntity articleData) goToDetail;

  DiscoverViewModel(
      {this.loadingStatus,
      this.articleDirectory,
      this.selectedArticle,
      this.fetchArticleDirectory,
      this.goToDetail});

  static DiscoverViewModel fromStore(Store<AppState> store) {
    return DiscoverViewModel(
        loadingStatus: store.state.discoverState.loadingStatus,
        articleDirectory: store.state.discoverState.articlesDirectory,
        selectedArticle: store.state.discoverState.selectedArticle,
        goToDetail: (ArticleEntity article) =>
            store.dispatch(GoToArticleDetailAction(article)),
        //TODO: Check
        fetchArticleDirectory: () => store.dispatch(FetchArticleDirectoryAction()));
  }
}
