import 'package:farmsmart_flutter/redux/home/home_actions.dart';
import 'package:farmsmart_flutter/redux/home/home_state.dart';
import 'package:farmsmart_flutter/redux/home/screens.dart';
import 'package:redux/redux.dart';

final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, SwitchTabAction>(_switchTab),
  // Any other action must be added to this reducer
]);

// The navigation middleware is made to change withing "activities" widgets, not "fragments" widgets.
HomeState _switchTab(HomeState state, SwitchTabAction action) {
  switch (action.screen) {
    case HomeScreen.MY_PLOT_TAB:
      return state.copyWith(currentHomeTab: HomeScreen.MY_PLOT_TAB);
      break;
    case HomeScreen.PROFIT_LOSS_TAB:
      return state.copyWith(currentHomeTab: HomeScreen.PROFIT_LOSS_TAB);
      break;
    case HomeScreen.ARTICLES_TAB:
      return state.copyWith(currentHomeTab: HomeScreen.ARTICLES_TAB);
      break;
    case HomeScreen.COMMUNITY_TAB:
      return state.copyWith(currentHomeTab: HomeScreen.COMMUNITY_TAB);
      break;
  }
  return state;
}
