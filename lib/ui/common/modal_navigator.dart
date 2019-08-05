import 'package:flutter/material.dart';

class NavigationScope extends StatelessWidget {
  NavigationScope({
    @required this.child,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static presentModal(BuildContext context, Widget child) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NavigationScope(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKey.currentState.maybePop(),
      child: Scaffold(
        body: child
      ),
    );
  }
}
