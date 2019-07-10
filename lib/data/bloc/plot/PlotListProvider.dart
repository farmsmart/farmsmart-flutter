import 'dart:async';

import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/data/model/PlotEntity.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotList.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotListItem.dart';

import 'PlotToPlotListItemViewModel.dart';

/*
       [Model]    ->               [Bloc]             -> [View]  
   [repo , model] -> [ViewModelProvider, Transformer] -> [viewModel, widget]
*/

class PlotListProvider implements ViewModelProvider<PlotListViewModel> {
  final PlotRepositoryInterface _repo;
  final String _title;
  PlotListViewModel _snapshot;
  PlotListProvider(
      {String title, PlotRepositoryInterface repository})
      : this._title = title, 
        this._repo = repository;

  final StreamController<PlotListViewModel> _controller =
      StreamController<PlotListViewModel>.broadcast();

  PlotListViewModel _modelFromPlots(
      StreamController controller, List<PlotEntity> plots) {
    final transformer = PlotToPlotListItemViewModel();
    final items = plots.map((plot) {
      return transformer.transform(from: plot);
    }).toList();
    return _viewModel(status: LoadingStatus.SUCCESS, items: items);
  }

  void _update(StreamController controller) {
    _repo.getFarm(null).then((articles) {
      _snapshot = _modelFromPlots(controller, articles);
      controller.sink.add(_snapshot);
    });
  }

  void _add() {
      _repo.addPlot();
      _update(_controller);
  }

  @override
  StreamController<PlotListViewModel> observe() {
    return _controller;
  }
  

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }

  @override
  PlotListViewModel initial() {
    if (_snapshot == null) {
      _snapshot = _viewModel(status: LoadingStatus.LOADING, items: []);
      _snapshot.update();
    }
    return _snapshot;
  }

  PlotListViewModel _viewModel({LoadingStatus  status, List<PlotListItemViewModel> items}){
    return PlotListViewModel(title: _title, buttonTitle: "Add crop", status: status, items: items, update: () => _update(_controller), add: () => _add());
  }


}
