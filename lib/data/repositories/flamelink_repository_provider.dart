import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/data/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/crop/implementation/MockCropRepository.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:flutter/material.dart';

import 'repository_provider.dart';

class FlameLinkRepositoryProvider implements RepositoryProvider {
  FlameLink cms;

  PlotRepositoryInterface _plot = MockPlotRepository();
  CropRepositoryInterface _crop = MockCropRepository();

  init(BuildContext context) {
    this.cms = FlameLink(
        store: Firestore.instance,
        environment: AppConfig.of(context).environment);
        _plot =  MockPlotRepository();
       _crop = MockCropRepository();
  }

  @override
  ArticleRepositoryInterface getArticleRepository() =>
      ArticlesRepositoryFlameLink(cms);

  //TODO Add My Plot FlameLink Repository
  @override
  PlotRepositoryInterface getMyPlotRepository() => _plot;

  @override
  CropRepositoryInterface getCropRepository() => _crop;
}
