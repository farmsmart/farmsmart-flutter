import 'dart:async';

import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/repositories/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleListViewModel.dart';


/*
       [Model]    ->               [Bloc]             -> [View]  
   [repo , model] -> [ViewModelProvider, Transformer] -> [viewModel, widget]
*/

class ArticleListProvider implements ViewModelProvider<ArticleListViewModel> {
  final ArticleRepositoryInterface _repo;
  final ArticleCollectionGroup _group;
  final String _title;
  ArticleListProvider(
      {String title, ArticleRepositoryInterface repository,
      ArticleCollectionGroup group = ArticleCollectionGroup.all})
      : this._title = title, 
        this._repo = repository,
        this._group = group;

  final StreamController<ArticleListViewModel> _controller =
      StreamController<ArticleListViewModel>.broadcast();

  ArticleListViewModel _modelFromArticles(
      StreamController controller, List<ArticleEntity> articles) {
    final detailTransformer = ArticleDetailViewModelTransformer();
    final transformer = ArticleListViewModelItemTransformer(
        detailTransformer: detailTransformer);
    detailTransformer.setListItemTransformer(
        transformer); //LH we add this after as depends on having the list transformer
    final items = articles.map((article) {
      return transformer.transform(from: article);
    }).toList();
    return ArticleListViewModel(
        title: _title,
        status: LoadingStatus.SUCCESS,
        articleListItemViewModels: items,
        update: () => _update(controller));
  }

  void _update(StreamController controller) {
    _repo.get(group: _group).then((articles) {
      controller.sink.add(_modelFromArticles(controller, articles));
    });
  }

  @override
  StreamController<ArticleListViewModel> provide() {
    _update(_controller);
    return _controller;
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
