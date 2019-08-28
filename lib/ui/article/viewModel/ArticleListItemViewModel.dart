import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';

class ArticleListItemViewModel {
  final String title;
  final String summary;
  final ImageURLProvider image;
  final ArticleDetailViewModel detailViewModel;

  ArticleListItemViewModel(
    this.title,
    this.summary,
    this.image,
    this.detailViewModel,
  );
}
