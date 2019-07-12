import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({
    @required this.child,
    @required this.navigatorKey,
    @required this.barItem,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavigationBarItem barItem;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder = (BuildContext _) => child;
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
