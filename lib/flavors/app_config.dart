import 'package:farmsmart_flutter/model/repositories/repository_provider.dart';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget{
  final String environment;
  final RepositoryProvider repositoryProvider;
  final String buildFlavor;
  final Widget child;

  AppConfig({
    @required this.environment,
    @required this.buildFlavor,
    @required this.child,
    @required this.repositoryProvider,
  });

  static AppConfig of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  bool isProductionBuild() => buildFlavor == "Production";
}
