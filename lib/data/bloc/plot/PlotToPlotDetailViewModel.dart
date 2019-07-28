import 'package:farmsmart_flutter/data/bloc/StaticViewModelProvider.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/recommendations/CropDetailtransformer.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';

import '../Transformer.dart';
import 'PlotToPlotListItemViewModel.dart';
import 'StageBusinessLogic.dart';
import 'StageToStageCardViewModel.dart';

class PlotToPlotDetailViewModel
    implements ObjectTransformer<PlotEntity, PlotDetailViewModel> {
  final _articleTransformer =
      ArticleListItemViewModelTransformer.buildWithDetail(
          ArticleDetailViewModelTransformer());
  final _cropTransformer = CropDetailTransformer();
  final StageToStageCardViewModel _stageTransformer;
  final Function _renameAction;
  final Function _removeAction;
  final PlotEntity _plot;
  final _logic = StageBusinessLogic();

  PlotToPlotDetailViewModel(
    this._plot,
    this._stageTransformer,
    this._renameAction,
    this._removeAction,
  );

  @override
  PlotDetailViewModel transform({PlotEntity from}) {
    if (from != null) {
      assert(from == _plot);
    } 
    final headerViewModel =
        PlotToPlotListItemViewModel(null).transform(from: _plot);
    final stageViewModels = _plot.stages.map((stage) {
      return _stageTransformer.transform(from: stage);
    }).toList();
    final List<ArticleDetailViewModel> artcileViewModels =
        _plot.stages.map((stage) {
      return _articleTransformer.transform(from: stage.article).detailViewModel;
    }).toList();

    final cropDetailModel =_cropTransformer.transform(from: _plot.crop);
    final detailProvider = StaticViewModelProvider(cropDetailModel);
    return PlotDetailViewModel(
        title: headerViewModel.title,
        detailText: headerViewModel.detail,
        imageProvider: CropImageProvider(_plot.crop),
        progress: headerViewModel.progress,
        stageCardViewModels: stageViewModels,
        stageArticleViewModels: artcileViewModels,
        currentStage: _logic.currentStageIndex(_plot.stages),
        remove: () => _removeAction(_plot),
        rename: _rename, 
        detailProvider: detailProvider);
  }

  _rename(String name) {
    _renameAction(_plot, name);
  }
}
