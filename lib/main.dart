import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/keys.dart';
import 'package:farmsmart_flutter/redux/store.dart';
import 'package:farmsmart_flutter/ui/discover/discover_detail_screen.dart';
import 'package:farmsmart_flutter/ui/home.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_current_stage_screen.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_detail_screen.dart';
import 'package:farmsmart_flutter/ui/privacy_policies_screen.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'app_routes.dart';

void main() async {
  // Defines app orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  var store = await createStore();
  runApp(FarmsmartApp(store));
}

class FarmsmartApp extends StatefulWidget {
  final Store<AppState> store;

  FarmsmartApp(this.store);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<FarmsmartApp> {
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Color(backgroundColor),
            primaryColor: const Color(backgroundColor),
            accentColor: const Color(primaryGrey),
          ),
          home: Home(),
          navigatorKey: Keys.navKey,
          routes: <String, WidgetBuilder>{
            // Here you need to add all the different navigation transitions you may have
            AppRoutes.cropDetail: (BuildContext context) => CropDetailScreen(),
            AppRoutes.cropCurrentStage: (BuildContext context) =>
                MyPlotCurrentStageScreen(),
            AppRoutes.articleDetail: (BuildContext context) =>
                ArticleDetailScreen(),
            AppRoutes.privacyPolicies: (BuildContext context) =>
                PrivacyPoliciesScreen(),
          }),
    );
  }
}
