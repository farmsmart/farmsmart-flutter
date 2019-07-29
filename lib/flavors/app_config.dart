import 'package:farmsmart_flutter/data/repositories/FlameLink.dart';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget{
  final Environment environment;
  final bool isMockData;
  final String buildFlavor;
  final Widget child;

  AppConfig({
    @required this.environment,
    @required this.buildFlavor,
    @required this.child,
    @required this.isMockData,
  });

  static AppConfig of(BuildContext context){
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
