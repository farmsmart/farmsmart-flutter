import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'repository_provider.dart';


class MockRepositoryProvider implements RepositoryProvider{

  init(BuildContext context){
    //ignore
  }
  
  @override
  ArticleRepositoryInterface getDiscoverRepository() => MockArticlesRepository();

  @override
  PlotRepositoryInterface getMyPlotRepository() => MockPlotRepository();

}
