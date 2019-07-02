import 'dart:async';

import 'package:farmsmart_flutter/data/model/ImageEntity.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleDetail.dart';
import 'package:farmsmart_flutter/utils/strings.dart';

class ArticleListItemViewModel {
  final String title;
  final String summary;
  final ImageEntityURLProvider image;
  final ArticleDetailViewModel detailViewModel;

  ArticleListItemViewModel(this.title, this.summary, this.image, this.detailViewModel);

   static ArticleListItemViewModel fromArticleEntityToViewModel(
      {ArticleEntity article}) {
    return ArticleListItemViewModel(
        article.title ?? Strings.noTitleString,
        article.summary ?? Strings.noTitleString,
        ArticleImageProvider(article), ArticleDetailViewModel.fromArticleEntityToViewModel(article));
  }
}

abstract class ArticleListViewModelProvider {
   StreamController<ArticleListViewModel> provide();
}

class ArticleListViewModel {
  final LoadingStatus loadingStatus;
  final List<ArticleListItemViewModel> articleListItemViewModels;
  Function update;

  ArticleListViewModel(
      {List<ArticleEntity> articleItems = const [], LoadingStatus loadingStatus = LoadingStatus.LOADING, Function update, Function onTap})
      : this.loadingStatus = loadingStatus,
        this.update = update,
        this.articleListItemViewModels = articleItems
            .map((entity) => ArticleListItemViewModel.fromArticleEntityToViewModel(article: entity)).toList();

}
