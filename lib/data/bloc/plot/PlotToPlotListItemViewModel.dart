import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/plot/StageBusinessLogic.dart';
import 'package:farmsmart_flutter/data/bloc/plot/StageToStageCardViewModel.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
import 'package:intl/intl.dart';

class _Strings {
  static const day = "Day";
  static const upcoming = "Upcoming";
}

class PlotToPlotListItemViewModel implements ObjectTransformer<PlotEntity, PlotListItemViewModel> {

  final _logic = StageBusinessLogic();
  final _articleTransformer = ArticleListItemViewModelTransformer.buildWithDetail(ArticleDetailViewModelTransformer());

  @override
  PlotListItemViewModel transform({PlotEntity from}) {
    final title = from.title;
    final detailText = _detailString(from: from);
    final stageTransformer = StageToStageCardViewModel(from.stages);
    final stageViewModels = from.stages.map((stage) {
        return stageTransformer.transform(from:stage);
      }).toList();
    final List<ArticleDetailViewModel> artcileViewModels = from.stages.map((stage) {
        return _articleTransformer.transform(from: stage.article).detailViewModel;
      }).toList();
    final detailViewModel = PlotDetailViewModel(title:title, detailText: detailText, stageCardViewModels: stageViewModels, stageArticleViewModels: artcileViewModels, currentStage: _logic.currentStageIndex(from.stages));

    return PlotListItemViewModel(title: title, subtitle:_subtitleString(from: from), detail: detailText, detailViewModel: detailViewModel, imageProvider: CropImageProvider(from.crop) );
  }

  String _subtitleString({PlotEntity from}) {
    return _logic.currentStage(from.stages).article.title;
  }

  String _detailString({PlotEntity from}) {
    final currentStage = _logic.currentStage(from.stages);
    final started = currentStage.started;
    if (started != null) {
       final daysSinceStarted = DateTime.now().difference(started).inDays;
      return Intl.message(_Strings.day) + " " + daysSinceStarted.toString();
    }
    return Intl.message(_Strings.upcoming) ;
  }
}