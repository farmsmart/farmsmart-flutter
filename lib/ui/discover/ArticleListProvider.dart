import 'dart:async';

import 'package:farmsmart_flutter/data/repositories/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleListViewModel.dart';

class ArticleListProvider implements ArticleListViewModelProvider {
  final ArticleRepositoryInterface _repo;
  final ArticleCollectionGroup _group;
  Function onTap;
  ArticleListProvider({ArticleRepositoryInterface repository, ArticleCollectionGroup group = ArticleCollectionGroup.all}) : this._repo = repository, this._group = group;

  void _update(StreamController controller) {
      _repo.get(group: _group).then( (articles) { 
        controller.sink.add(ArticleListViewModel(articleItems: articles, loadingStatus: LoadingStatus.SUCCESS, update: () => _update(controller), onTap: onTap) );
      });
  }

  @override
  StreamController<ArticleListViewModel> provide() {
    final controller = StreamController<ArticleListViewModel>();
    _update(controller);
    return controller;
  }

}
