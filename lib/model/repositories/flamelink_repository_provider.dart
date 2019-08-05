import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/crop/implementation/MockCropRepository.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/implementation/MockTransactionRepository.dart';
import 'package:flutter/material.dart';

import 'repository_provider.dart';

class FlameLinkRepositoryProvider implements RepositoryProvider {
  FlameLink cms;

  PlotRepositoryInterface _plot = MockPlotRepository();
  CropRepositoryInterface _crop = MockCropRepository();
  TransactionRepositoryInterface _trans = MockTransactionRepository();

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

  @override
  TransactionRepositoryInterface getTransactionRepository() => _trans;
}
