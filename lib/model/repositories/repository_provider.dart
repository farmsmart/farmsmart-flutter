import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:flutter/material.dart';

import 'crop/CropRepositoryInterface.dart';

abstract class RepositoryProvider {

  init(BuildContext context);

  ArticleRepositoryInterface getArticleRepository();

  PlotRepositoryInterface getMyPlotRepository();

  CropRepositoryInterface  getCropRepository();

  TransactionRepositoryInterface getTransactionRepository();
}
