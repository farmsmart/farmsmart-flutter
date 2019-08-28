import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';

class ArticleListViewModel implements LoadableViewModel, RefreshableViewModel {
  final String title;
  final LoadingStatus loadingStatus;

  final List<ArticleListItemViewModel> articleListItemViewModels;
  final Function refresh;

  ArticleListViewModel({
    String title,
    LoadingStatus status,
    List<ArticleListItemViewModel> articleListItemViewModels,
    Function refresh,
  })  : this.title = title,
        this.loadingStatus = status,
        this.articleListItemViewModels = articleListItemViewModels,
        this.refresh = refresh;
}
