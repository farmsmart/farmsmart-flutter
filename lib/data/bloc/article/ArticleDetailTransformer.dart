import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleListItemViewModel.dart';

/*
      Transform:
      [ArticleEntity] -> [ArticleDetailViewModel]
*/
class ArticleDetailViewModelTransformer
    implements ObjectTransformer<ArticleEntity, ArticleDetailViewModel> {
  ObjectTransformer<ArticleEntity, ArticleListItemViewModel>
      _listItemTransformer;

  ArticleDetailViewModelTransformer(
      {ObjectTransformer<ArticleEntity, ArticleListItemViewModel>
          listItemTransformer})
      : this._listItemTransformer = listItemTransformer;

  void setListItemTransformer(
      ArticleListViewModelItemTransformer transformer) {
    _listItemTransformer = transformer;
  }

  @override
  ArticleDetailViewModel transform({ArticleEntity from}) {
    ArticleDetailViewModel viewModel = ArticleDetailViewModel(
        LoadingStatus.SUCCESS,
        from.title,
        from.summary,
        ArticleImageProvider(from),
        from.content,
        null);
    viewModel.getRelated = () {
      if (from.related == null) {
        return Future.value([]);
      }
      return from.related.getEntities().then((articles) {
        return articles.map((article) {
          return _listItemTransformer.transform(from: article);
        }).toList();
      });
    };
    return viewModel;
  }
}
