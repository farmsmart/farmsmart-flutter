import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:flutter/material.dart';


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

  //TODO Add My Plot FlameLink Repository
  PlotRepositoryInterface getMyPlotRepository() {
    return isMockData ? MockPlotRepository() : MockPlotRepository();
  }

}
