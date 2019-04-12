import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:redux/redux.dart';


// Here add any navigation between screens (doesnt include tab navigation)
class NavigationMiddleware extends MiddlewareClass<AppState>{
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
//    if(action is GoToCropDetailAction){
//      Keys.navKey.currentState.pushNamed(AppRoutes.cropDetail);
//    }
    next(action);
  }
}