import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';

class DiscoverViewModel {
  final LoadingStatus loadingStatus;
  final List<ArticleEntity> articleItems;

  DiscoverViewModel({List<ArticleEntity> articleItems, LoadingStatus loadingStatus}) : this.loadingStatus = loadingStatus, this.articleItems = articleItems ;

  static DiscoverViewModel fromStore(Store<AppState> store) {
    return DiscoverViewModel(
        loadingStatus: store.state.discoverState.loadingStatus, articleItems: store.state.discoverState.articles
        );
  }
}
