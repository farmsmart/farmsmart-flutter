import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'data/repositories/FlameLink.dart';
import 'data/repositories/article/ArticleRepositoryInterface.dart';
import 'data/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'data/repositories/article/implementation/MockArticlesRepository.dart';
import 'data/repositories/plot/PlotRepositoryInterface.dart';
import 'data/repositories/plot/implementation/MockPlotRepository.dart';
import 'flavors/app_config.dart';

class RepositoryProvider {
  final BuildContext context;

  FlameLink cms;
  bool isMockData;

  RepositoryProvider({this.context});

  init() {
    cms = FlameLink(
        store: Firestore.instance,
        environment: AppConfig.of(context).environment);

    isMockData = AppConfig.of(context).isMockData;
  }

  ArticleRepositoryInterface getDiscoverRepository() {
    return isMockData
        ? MockArticlesRepository()
        : ArticlesRepositoryFlameLink(cms);
  }

  //TODO Add FlameLink Repository
  PlotRepositoryInterface getMyPlotRepository() {
    return isMockData ? MockPlotRepository() : MockPlotRepository();
  }
}
