import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:flutter/material.dart';

abstract class RepositoryProvider {

  init(BuildContext context);

  ArticleRepositoryInterface getDiscoverRepository();

  PlotRepositoryInterface getMyPlotRepository();
}
