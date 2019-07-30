import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:flutter/material.dart';

import 'crop/CropRepositoryInterface.dart';

abstract class RepositoryProvider {

  init(BuildContext context);

  ArticleRepositoryInterface getArticleRepository();

  PlotRepositoryInterface getMyPlotRepository();

  CropRepositoryInterface  getCropRepository();
}
