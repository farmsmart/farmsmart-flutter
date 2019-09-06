import 'dart:async';

import 'package:farmsmart_flutter/model/entities/StageEntity.dart';
import 'package:farmsmart_flutter/model/entities/PlotEntity.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';

import '../ViewModelProvider.dart';
import 'PlotToPlotDetailViewModel.dart';
import 'StageBusinessLogic.dart';
import 'StageToStageCardViewModel.dart';

class PlotDetailProvider implements ViewModelProvider<PlotDetailViewModel> {
  PlotDetailViewModel _snapshot;

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
      _repo.observeSingle(_plot.uri).listen((plot) {
        if(plot != null){
           _plot = plot;
          _snapshot = _viewModel();
          _controller.sink.add(_snapshot);
        }
      });
    }
    return _snapshot;
  }

  @override
  Stream<PlotDetailViewModel> stream() {
    return _controller.stream;
  }
  
  @override
  PlotDetailViewModel snapshot() {
    return _snapshot;
  }

  PlotDetailViewModel _viewModel() {
    final stageTransformer = StageToStageCardViewModel(
      _plot,
      _beginStageAction,
      _completeStageAction,
      _revertStageAction,
    );
    final detailTransformer = PlotToPlotDetailViewModel(
      _plot,
      stageTransformer,
      _rename,
      _remove,
    );
    return detailTransformer.transform();
  }

  //LH here we complete the stage and begin the next if not the last stage, as per business requirements
  void _completeStageAction(PlotEntity plot, StageEntity stage) {
    final beginNext = stage != plot.stages.last;
    _repo.completeStage(plot, stage).then((plot) {
      final currentStage = _logic.currentStage(plot.stages);
      if (beginNext) {
        _repo.beginStage(plot, currentStage).then((plot) {
          _plot = plot;
        });
      } else {
        _plot = plot;
      }
    });
  }

  void _beginStageAction(PlotEntity plot, StageEntity stage) {
    _repo.beginStage(plot, stage).then((plot) {
      _plot = plot;
    });
  }

  void _revertStageAction(PlotEntity plot, StageEntity stage) {
    _repo.revertStage(plot, stage).then((plot) {
      _plot = plot;
    });
  }

  void _remove(PlotEntity plot) {
    _repo.remove(plot).then((success) {
      //TODO: what if this failed?
    });
  }

  void _rename(PlotEntity plot, String name) {
    _repo.rename(plot, name).then((plot) {
      _plot = plot;
    });
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
