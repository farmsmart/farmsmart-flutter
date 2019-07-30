import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/data/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/crop/implementation/MockCropRepository.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:flutter/widgets.dart';
import 'repository_provider.dart';


class MockRepositoryProvider implements RepositoryProvider{

  PlotRepositoryInterface _plot = MockPlotRepository();
  CropRepositoryInterface _crop = MockCropRepository();

  init(BuildContext context){
    //ignore
  }
  
  @override
  ArticleRepositoryInterface getDiscoverRepository() => MockArticlesRepository();

  @override
  PlotRepositoryInterface getMyPlotRepository() => _plot;

  @override
  CropRepositoryInterface getCropRepository() => _crop;

}
