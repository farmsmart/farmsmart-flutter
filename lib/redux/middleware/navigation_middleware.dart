import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/home_actions.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';

import '../../app_routes.dart';
import '../keys.dart';


// Here add any navigation between screens (doesnt include tab navigation)
class NavigationMiddleware extends MiddlewareClass<AppState>{
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if(action is GoToCropDetailAction){
      Keys.navKey.currentState.pushNamed(AppRoutes.cropDetail);
    }
    if(action is GoToStageAction){
      Keys.navKey.currentState.pushNamed(AppRoutes.cropCurrentStage);
    }
    if(action is GoToArticleDetailAction) {
      Keys.navKey.currentState.pushNamed(AppRoutes.articleDetail);
    }
    if (action is FetchSingleArticleAction) {
      Keys.navKey.currentState.popUntil((route) => route.isFirst);
    }
    if(action is GoToPrivacyPoliciesAction) {
      Keys.navKey.currentState.pushNamed(AppRoutes.privacyPolicies);
    }
    next(action);
  }
}

