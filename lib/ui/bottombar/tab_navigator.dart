import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {

  TabNavigator({this.navigatorKey, this.child, this.barItem});

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget child;
  final BottomNavigationBarItem barItem;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder =
            (BuildContext _) => child;
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}