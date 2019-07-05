import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleListItemViewModel.dart';
import 'package:farmsmart_flutter/utils/strings.dart';

/*
      Transform:
      [ArticleEntity] -> [ArticleListItemViewModel]
*/

class ArticleListItemViewModelTransformer
    implements ObjectTransformer<ArticleEntity, ArticleListItemViewModel> {
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
        from.title ?? Strings.noTitleString,
        from.summary ?? "",
        ArticleImageProvider(from),
        detailViewModel);
  }
}
