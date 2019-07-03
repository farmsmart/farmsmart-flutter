import 'dart:async';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/app/app_reducer.dart';
import 'package:farmsmart_flutter/redux/middleware/navigation_middleware.dart';
import 'package:farmsmart_flutter/redux/middleware/plot_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';


Future<Store<AppState>> createStore() async {
//  var prefs = await SharedPreferences.getInstance();
  return Store(
    appReducer,
    initialState: AppState.initial(),
    
    // Add here all the middlewares to be used in the app. The order DOES matter.
    middleware: [
      LoggingMiddleware.printer(),
      NavigationMiddleware(),
      MyPlotMiddleWare()
    ],
  );
}