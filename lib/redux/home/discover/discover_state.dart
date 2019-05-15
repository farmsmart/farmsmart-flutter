import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:meta/meta.dart';



@immutable
class DiscoverState {
  final LoadingStatus loadingStatus;
  final ArticlesDirectoryEntity articlesDirectory;
  final ArticleEntity selectedArticle;

  DiscoverState(
      {@required this.loadingStatus,
      @required this.articlesDirectory,
      this.selectedArticle});

  factory DiscoverState.initial() {
    return new DiscoverState(
        loadingStatus: LoadingStatus.LOADING, articlesDirectory: ArticlesDirectoryEntity());
  }

  DiscoverState copyWith(
      {LoadingStatus loadingStatus,
      ArticlesDirectoryEntity articlesDirectory,
      ArticleEntity selectedArticle}) {
    return new DiscoverState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        articlesDirectory: articlesDirectory ?? this.articlesDirectory,
        selectedArticle: selectedArticle ?? this.selectedArticle);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscoverState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          articlesDirectory == other.articlesDirectory &&
          selectedArticle == other.selectedArticle;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^ articlesDirectory.hashCode ^ selectedArticle.hashCode;
}
