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
      return state.copyWith(currentHomeTab: 0);
      break;
    case HomeScreen.PROFIT_LOSS_TAB:
      return state.copyWith(currentHomeTab: 1);
      break;
    case HomeScreen.ARTICLES_TAB:
      return state.copyWith(currentHomeTab: 2);
      break;
    case HomeScreen.COMMUNITY_TAB:
      return state.copyWith(currentHomeTab: 3);
      break;
  }
  return state;
}
