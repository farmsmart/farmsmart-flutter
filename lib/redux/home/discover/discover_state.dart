import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:meta/meta.dart';

@immutable
class DiscoverState {
  final LoadingStatus loadingStatus;
  final List<ArticleEntity> articles;

  DiscoverState({this.articles, this.loadingStatus});

  factory DiscoverState.initial() {
    return new DiscoverState(
        loadingStatus: LoadingStatus.LOADING, articles: []);
  }

  DiscoverState copyWith({
        LoadingStatus loadingStatus,
        List<ArticleEntity> articles
      }) {
    return DiscoverState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        articles: articles ?? this.articles
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoverState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          articles == other.articles
  ;

  @override
  int get hashCode =>
      loadingStatus.hashCode  ^ articles.hashCode;
}
