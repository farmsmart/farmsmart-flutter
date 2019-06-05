
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_state.dart';
import 'package:redux/redux.dart';

final discoverReducer = combineReducers<DiscoverState>([
  TypedReducer<DiscoverState, UpdateArticleDirectoryAction>(_updateArticles),
  TypedReducer<DiscoverState, GoToArticleDetailAction>(_goToArticleDetail),
  TypedReducer<DiscoverState, FetchRelatedArticlesAction>(_fetchRelatedArticles),
  TypedReducer<DiscoverState, UpdateRelatedArticlesAction>(_updateRelatedArticles),
]);


DiscoverState _updateArticles(DiscoverState state, UpdateArticleDirectoryAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.SUCCESS, articlesDirectory: action.articlesDirectory);

DiscoverState _goToArticleDetail(DiscoverState state, GoToArticleDetailAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.LOADING, selectedArticleWithRelated: action.article);

DiscoverState _fetchRelatedArticles(DiscoverState state, FetchRelatedArticlesAction action) =>
    state.copyWith(selectedArticleWithRelated: action.articleWithRelated);

DiscoverState _updateRelatedArticles(DiscoverState state, UpdateRelatedArticlesAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.SUCCESS, selectedArticleWithRelated: action.articleWithRelated);