import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleListItemViewModel.dart';


class ArticleListViewModel {
  final String title; 
  final LoadingStatus loadingStatus;

  final List<ArticleListItemViewModel> articleListItemViewModels;
  final Function update;

  ArticleListViewModel({String title, LoadingStatus status, List<ArticleListItemViewModel> articleListItemViewModels, Function update}) : this.title = title,this.loadingStatus = status, this.articleListItemViewModels = articleListItemViewModels, this.update = update;
}
