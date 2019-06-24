
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_state.dart';
import 'package:redux/redux.dart';

final discoverReducer = combineReducers<DiscoverState>([
  TypedReducer<DiscoverState, UpdateArticlesAction>(_updateArticles),
]);

DiscoverState _updateArticles(DiscoverState state, UpdateArticlesAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.SUCCESS, articles: action.articles);