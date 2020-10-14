import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';

import 'ArticleDetailTransformer.dart';

/*
      Transform:
      [ArticleEntity] -> [ArticleListItemViewModel]
*/

class _Strings {
  static const titleDefault = "";
  static const summaryDefault= "";
}

class ArticleListItemViewModelTransformer
    extends ObjectTransformer<ArticleEntity, ArticleListItemViewModel> {
  final ObjectTransformer<ArticleEntity, ArticleDetailViewModel>
      _detailTransformer;

  ArticleListItemViewModelTransformer(
      {ObjectTransformer<ArticleEntity, ArticleDetailViewModel>
          detailTransformer})
      : this._detailTransformer = detailTransformer;
  @override
  ArticleListItemViewModel transform({ArticleEntity from}) {
    ArticleDetailViewModel detailViewModel =
        _detailTransformer.transform(from: from);
    return ArticleListItemViewModel(
        from.title ?? _Strings.titleDefault,
        from.summary ?? _Strings.summaryDefault,
        ArticleImageProvider(from),
        detailViewModel);
  }


  static ArticleListItemViewModelTransformer buildWithDetail(ArticleDetailViewModelTransformer detail) {
    final transformer = ArticleListItemViewModelTransformer(
        detailTransformer: detail);
    detail.setListItemTransformer(transformer);
      return transformer;
  }
}
