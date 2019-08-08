import 'package:flutter/material.dart';

class NavigationScope {
  NavigationScope({
    @required this.child,
  });

  final Widget child;

  static presentModal(BuildContext context, Widget child) {
    showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => child,
    );
  }
}
