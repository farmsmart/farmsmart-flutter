import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:meta/meta.dart';



@immutable
class DiscoverState {
  final LoadingStatus loadingStatus;
  final List<ArticleEntity> articleList;
  final ArticleEntity selectedArticle;

  DiscoverState(
      {@required this.loadingStatus,
      @required this.articleList,
      this.selectedArticle});

  factory DiscoverState.initial() {
    return new DiscoverState(
        loadingStatus: LoadingStatus.LOADING, articleList: List());
  }

  DiscoverState copyWith(
      {LoadingStatus loadingStatus,
      List<ArticleEntity> articleList,
      ArticleEntity selectedArticle}) {
    return new DiscoverState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        articleList: articleList ?? this.articleList,
        selectedArticle: selectedArticle ?? this.selectedArticle);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoverState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          articleList == other.articleList &&
          selectedArticle == other.selectedArticle;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^ articleList.hashCode ^ selectedArticle.hashCode;
}
