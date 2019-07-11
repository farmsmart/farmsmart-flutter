import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {

  TabNavigator({this.navigatorKey, this.child});
  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;

//  void _push(BuildContext context, {int materialIndex: 500}) {
//    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);
//
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) =>
//                routeBuilders[TabNavigatorRoutes.detail](context)));
//  }

//  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
//      {int materialIndex: 500}) {
//    return {
//      TabNavigatorRoutes.root: (context) => ColorsListPage(
//        color: TabHelper.color(tabItem),
//        title: TabHelper.description(tabItem),
//        onPush: (materialIndex) =>
//            _push(context, materialIndex: materialIndex),
//      ),
//      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
//        color: TabHelper.color(tabItem),
//        title: TabHelper.description(tabItem),
//        materialIndex: materialIndex,
//      ),
//    };
//  }

  @override
  Widget build(BuildContext context) {
    return Navigator();
//    return Navigator(
//        key: navigatorKey,
//        initialRoute: TabNavigatorRoutes.root,
//        onGenerateRoute: (routeSettings) {
//          return MaterialPageRoute(
//              builder: (context) => routeBuilders[routeSettings.name](context));
//        });
  }
}