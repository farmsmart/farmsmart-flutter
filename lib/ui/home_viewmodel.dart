import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/home_actions.dart';
import 'package:farmsmart_flutter/redux/home/screens.dart';
import 'package:redux/redux.dart';

class HomeViewmodel {
  LoadingStatus loadingStatus;
  final int currentTab;
  ArticleEntity articleEntity;

  final Function showMyPlotChild;
  final Function showProfitLossChild;
  final Function showArticlesChild;
  final Function showCommunityChild;
  final Function goToPrivacyPolicy;
  final Function showDebugMenu;

  HomeViewmodel(
      {this.loadingStatus,
      this.currentTab,
      this.showArticlesChild,
      this.showCommunityChild,
      this.showMyPlotChild,
      this.showProfitLossChild,
      this.goToPrivacyPolicy,
      this.showDebugMenu});

  static HomeViewmodel fromStore(Store<AppState> store) {
    return HomeViewmodel(
        loadingStatus: store.state.homeState.loadingStatus,
        currentTab: store.state.homeState.currentHomeTab,
        showMyPlotChild: () =>
            store.dispatch(SwitchTabAction(HomeScreen.MY_PLOT_TAB)),
        showProfitLossChild: () =>
            store.dispatch(SwitchTabAction(HomeScreen.PROFIT_LOSS_TAB)),
        showArticlesChild: () =>
            store.dispatch(SwitchTabAction(HomeScreen.ARTICLES_TAB)),
        showCommunityChild: () =>
          store.dispatch(SwitchTabAction(HomeScreen.COMMUNITY_TAB)),
        goToPrivacyPolicy: (String value) =>
            store.dispatch(GoToPrivacyPoliciesAction()),
        showDebugMenu: () =>
            store.dispatch(SwitchTabAction(HomeScreen.DEBUG_TAB)),);
  }

  void changeTab(int value) {
    switch (value) {
      case HomeScreen.MY_PLOT_TAB:
        showMyPlotChild();
        break;
      case HomeScreen.PROFIT_LOSS_TAB:
        showProfitLossChild();
        break;
      case HomeScreen.ARTICLES_TAB:
        showArticlesChild();
        break;
      case HomeScreen.COMMUNITY_TAB:
        showCommunityChild();
        break;
      case HomeScreen.DEBUG_TAB:
        showDebugMenu();
        break;
    }
  }
}
