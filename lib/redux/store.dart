import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/repositories/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/FlameLink.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/app/app_reducer.dart';
import 'package:farmsmart_flutter/redux/middleware/navigation_middleware.dart';
import 'package:farmsmart_flutter/redux/middleware/plot_middleware.dart';
import 'package:farmsmart_flutter/redux/middleware/discover_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';


Future<Store<AppState>> createStore() async {
//  var prefs = await SharedPreferences.getInstance();
  final mockArticleRepo = MockArticlesRepository();
  final  cms = FlameLink(store: Firestore.instance);
  final articleRepo = ArticlesRepositoryFlameLink(cms);
  return Store(
    appReducer,
    initialState: AppState.initial(),
    
    // Add here all the middlewares to be used in the app. The order DOES matter.
    middleware: [
      LoggingMiddleware.printer(),
      NavigationMiddleware(),
      MyPlotMiddleWare(),
      DiscoverMiddleWare(articleRepo)
    ],
  );
}