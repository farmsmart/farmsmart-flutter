import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/home_actions.dart';
import 'package:farmsmart_flutter/redux/home/screens.dart';
import 'package:redux/redux.dart';

class HomeViewmodel {
  LoadingStatus loadingStatus;
  final int currentTab;

  final Function showMyPlotChild;
  final Function showProfitLossChild;
  final Function showArticlesChild;
  final Function showCommunityChild;

  HomeViewmodel({this.loadingStatus,
    this.currentTab,
    this.showArticlesChild,
    this.showCommunityChild,
    this.showMyPlotChild,
    this.showProfitLossChild});

  static HomeViewmodel fromStore(Store<AppState> store) {
    return HomeViewmodel(
        loadingStatus: store.state.homeState.loadingStatus,
        currentTab: store.state.homeState.currentHomeTab,
        showMyPlotChild: () =>
            store.dispatch(new SwitchTabAction(HomeScreen.MY_PLOT_TAB)),
        showProfitLossChild: () =>
            store.dispatch(new SwitchTabAction(HomeScreen.PROFIT_LOSS_TAB)),
        showArticlesChild: () =>
            store.dispatch(new SwitchTabAction(HomeScreen.ARTICLES_TAB)),
        showCommunityChild: () =>
            store.dispatch(new SwitchTabAction(HomeScreen.COMMUNITY_TAB)));
  }

  void changeTab(int value) {
    switch (value) {
      case 0:
        showMyPlotChild();
        break;
      case 1:
        showProfitLossChild();
        break;
      case 2:
        showArticlesChild();
        break;
      case 3:
        showCommunityChild();
        break;
    }
  }
}