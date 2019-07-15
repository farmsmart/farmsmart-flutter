import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/model/mock/MockArticle.dart';
import 'package:farmsmart_flutter/data/model/mock/MockString.dart';
import 'package:farmsmart_flutter/data/repositories/MockStrings.dart';
import 'package:farmsmart_flutter/data/repositories/image/implementation/MockImageEntity.dart';
import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';


class MockPlotDetailViewModel {
  static PlotDetailViewModel build() {
    final List<StageCardViewModel> cardViewModels = [];
    final articleViewModels = [ArticleDetailViewModelTransformer().transform(from: MockArticle().build()),
    ArticleDetailViewModelTransformer().transform(from: MockArticle().build()),
    ArticleDetailViewModelTransformer().transform(from: MockArticle().build()),
    ArticleDetailViewModelTransformer().transform(from: MockArticle().build())];
    return PlotDetailViewModel(title: mockTitleText.random(), 
    detailText: _days.random(), 
    progress: 0.5, 
    imageProvider: MockImageEntity().build().urlProvider, 
    stageCardViewModels: cardViewModels, 
    stageArticleViewModels: articleViewModels, currentStage: 1);
  }
}


MockString _days = MockString(library: ["Day 1","Day 2", "Day 3", "Day 4"]);