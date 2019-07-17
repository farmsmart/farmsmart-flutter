import 'dart:async';

import 'package:farmsmart_flutter/data/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/model/NewStageEntity.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';

import '../ViewModelProvider.dart';
import 'PlotToPlotListItemViewModel.dart';
import 'StageBusinessLogic.dart';
import 'StageToStageCardViewModel.dart';

class PlotDetailProvider implements ViewModelProvider<PlotDetailViewModel> {

  PlotDetailViewModel _snapshot;
  final _articleTransformer = ArticleListItemViewModelTransformer.buildWithDetail(ArticleDetailViewModelTransformer());
  PlotEntity _plot;
  final PlotRepositoryInterface _repo;
  final StreamController<PlotDetailViewModel> _controller =
      StreamController<PlotDetailViewModel>.broadcast();
  final _logic = StageBusinessLogic();
  PlotDetailProvider(this._plot, this._repo);

  @override
  PlotDetailViewModel initial() {
     if (_snapshot == null) {
      _snapshot = _viewModel();
      _repo.observe(_plot.id).listen((plot) {
        _plot = plot;
        _snapshot = _viewModel();
        _controller.sink.add(_snapshot);
      });
    }
    return _snapshot;
  }

  @override
  StreamController<PlotDetailViewModel> observe() {
    return _controller;
  }

   PlotDetailViewModel _viewModel(){
    final headerViewModel = PlotToPlotListItemViewModel(null).transform(from: _plot);
    final stageTransformer = StageToStageCardViewModel(_plot,_beginStageAction,_completeStageAction, _revertStageAction);
    final stageViewModels = _plot.stages.map((stage) {
        return stageTransformer.transform(from:stage);
      }).toList();
    final List<ArticleDetailViewModel> artcileViewModels = _plot.stages.map((stage) {
        return _articleTransformer.transform(from: stage.article).detailViewModel;
      }).toList();
    final detailViewModel = PlotDetailViewModel(title: headerViewModel.title, detailText: headerViewModel.detail, progress: headerViewModel.progress, stageCardViewModels: stageViewModels, stageArticleViewModels: artcileViewModels, currentStage: _logic.currentStageIndex(_plot.stages));
    return detailViewModel;
  }

  void _completeStageAction(PlotEntity plot, NewStageEntity stage) {
    _repo.completeStage(plot,stage).then((plot) {
      _plot  = plot;
     });
  }

  void _beginStageAction(PlotEntity plot, NewStageEntity stage) {
    _repo.beginStage(plot,stage).then((plot) {
      _plot  = plot;
     });
  }

  void _revertStageAction(PlotEntity plot, NewStageEntity stage) {
     _repo.revertStage(plot,stage).then((plot) {
      _plot  = plot;
     });
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }

}