import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/home_actions.dart';
import 'package:redux/redux.dart';

import '../../app_routes.dart';
import '../keys.dart';


// Here add any navigation between screens (doesnt include tab navigation)
class NavigationMiddleware extends MiddlewareClass<AppState>{
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if(action is GoToPrivacyPoliciesAction) {
      Keys.navKey.currentState.pushNamed(AppRoutes.privacyPolicies);
    }
    next(action);
  }
}

