import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListViewModel.dart';

/*
       [Model]    ->               [Bloc]             -> [View]  
   [repo , model] -> [ViewModelProvider, Transformer] -> [viewModel, widget]
*/

class ArticleListProvider implements ViewModelProvider<ArticleListViewModel> {
  final ArticleRepositoryInterface _repo;
  final ArticleCollectionGroup _group;
  final String _title;
  final String _relatedTitle;
  final String _contentLinkTitle;
  final String _contentLinkDescription;
  final String _contentLinkIcon;
  ArticleListViewModel _snapshot;

  ArticleListProvider({
    String title,
    String relatedTitle,
    String contentLinkTitle,
    ArticleRepositoryInterface repository,
    ArticleCollectionGroup group = ArticleCollectionGroup.all,
    String contentLinkDescription,
    String contentLinkIcon,
  })  : this._title = title,
        this._relatedTitle = relatedTitle,
        this._contentLinkTitle = contentLinkTitle,
        this._repo = repository,
        this._group = group,
        this._contentLinkDescription = contentLinkDescription,
        this._contentLinkIcon = contentLinkIcon;

  final StreamController<ArticleListViewModel> _controller =
      StreamController<ArticleListViewModel>.broadcast();

  ArticleListViewModel _modelFromArticles(
      StreamController controller, List<ArticleEntity> articles) {
    final transformer = ArticleListItemViewModelTransformer.buildWithDetail(
      ArticleDetailViewModelTransformer(
        relatedTitle: _relatedTitle,
        contentLinkTitle: _contentLinkTitle,
        contentLinkDescription: _contentLinkDescription,
        contentLinkIcon: _contentLinkIcon,
      ),
    );
    final items = articles.map((article) {
      return transformer.transform(from: article);
    }).toList();
    return _viewModel(
      status: LoadingStatus.SUCCESS,
      items: items,
    );
  }

  void _update(StreamController controller) {
    _repo.get(group: _group).then((articles) {
      _snapshot = _modelFromArticles(controller, articles);
      controller.sink.add(_snapshot);
    });
  }

  ArticleListViewModel _viewModel({
    LoadingStatus status,
    List<ArticleListItemViewModel> items,
  }) {
    return ArticleListViewModel(
        title: _title,
        status: status,
        articleListItemViewModels: items,
        refresh: () => _update(_controller));
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }

  @override
  ArticleListViewModel initial() {
    if (_snapshot == null) {
      _snapshot = _viewModel(
        status: LoadingStatus.LOADING,
        items: [],
      );
      _snapshot.refresh();
    }
    return _snapshot;
  }

  @override
  Stream<ArticleListViewModel> stream() {
    return _controller.stream;
  }

  @override
  ArticleListViewModel snapshot() {
    return _snapshot;
  }
}
