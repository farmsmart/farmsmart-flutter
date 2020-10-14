import 'package:farmsmart_flutter/model/analytics_interface.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({
    @required this.child,
    @required this.barItem,
    @required this.analyticsName,
  });

  final Widget child;
  final BottomNavigationBarItem barItem;
  final String analyticsName;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      observers: [AnalyticsInterface.implementation().navigationObserver],
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder = (BuildContext _) => child;
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
