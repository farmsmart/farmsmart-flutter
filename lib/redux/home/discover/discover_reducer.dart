
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_state.dart';
import 'package:redux/redux.dart';

final discoverReducer = combineReducers<DiscoverState>([
  TypedReducer<DiscoverState, UpdateArticleDirectoryAction>(_updateArticles),
  TypedReducer<DiscoverState, GoToArticleDetailAction>(_goToArticleDetail),
]);

DiscoverState _updateArticles(DiscoverState state, UpdateArticleDirectoryAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.SUCCESS, articlesDirectory: action.articlesList);

DiscoverState _goToArticleDetail(DiscoverState state, GoToArticleDetailAction action) =>
    state.copyWith(selectedArticle: action.article);