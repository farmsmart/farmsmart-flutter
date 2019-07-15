import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({
    @required this.child,
    @required this.barItem,
  });

  final Widget child;
  final BottomNavigationBarItem barItem;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
