import 'dart:async';

import 'package:farmsmart_flutter/data/bloc/Basket.dart';
import 'package:farmsmart_flutter/data/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card.dart';
import 'package:farmsmart_flutter/ui/recommendations/viewmodel/RecommendationsListViewModel.dart';

import '../ViewModelProvider.dart';
import 'RecommendationCardTransformer.dart';

class RecommendationListProvider
    implements ViewModelProvider<RecommendationsListViewModel> {
  final String _title;
  final double _inputScale;
  final CropRepositoryInterface _cropRepo;
  final PlotRepositoryInterface _plotRepo;
  Basket<CropEntity> _cropBasket;
  List<CropEntity> _crops;
  //final UserProfileRepositoryInterface _profileRepo; //we need the current input factors from this. 
  final _controller = StreamController<RecommendationsListViewModel>.broadcast();
  RecommendationsListViewModel _snapshot;

  RecommendationListProvider({
    String title,
    CropRepositoryInterface cropRepo,
    PlotRepositoryInterface plotRepo,
    double inputScale,
  })  : this._title = title,
        this._cropRepo = cropRepo,
        this._plotRepo = plotRepo,
        this._inputScale = inputScale;

  @override
  RecommendationsListViewModel initial() {
    if (_snapshot == null) {
      _cropBasket = Basket<CropEntity>(_basketDidChange);
      _snapshot = _viewModel(
        status: LoadingStatus.LOADING,
        items: [],
      );
      _snapshot.update();
    }
    return _snapshot;
  }

  @override
  StreamController<RecommendationsListViewModel> observe() {
    return _controller;
  }

  @override
  RecommendationsListViewModel snapshot() {
    return _snapshot;
  }

  RecommendationsListViewModel _viewModel(
      {LoadingStatus status, List<RecommendationCardViewModel> items}) {
    return RecommendationsListViewModel(
        title: _title,
        items: items,
        status: LoadingStatus.LOADING,
        canApply: !_cropBasket.isEmpty(),
        update: () => _update(_controller),
        apply: () => _add(_controller),
        clear: () => _clear(_controller));
  }

  RecommendationsListViewModel _modelFromCrops(
      StreamController<RecommendationsListViewModel> controller,
      List<CropEntity> crops) {
    final recommendationBusinessLogic = RecommendationEngine(
      inputFactors: {},
      inputScale: _inputScale,
      weightMatrix: {},
    );
    final transformer = RecommendationCardTransformer(
      engine: recommendationBusinessLogic,
      basket: _cropBasket,
    );
    final items = crops.map((crop) {
      return transformer.transform(from: crop);
    }).toList();
    return _viewModel(status: LoadingStatus.SUCCESS, items: items);
  }

  void _basketDidChange(List<CropEntity> old) {
    _snapshot = _modelFromCrops(_controller, _crops);
    _controller.sink.add(_snapshot);
  }

  void _update(StreamController<RecommendationsListViewModel> controller) {
    _cropRepo.get().then((crops) {
      _crops = crops;
      _snapshot = _modelFromCrops(controller, crops);
      controller.sink.add(_snapshot);
    });
  }

  void _add(StreamController<RecommendationsListViewModel> controller) {
    final cropsToAdd = _cropBasket.empty();
    for (var crop in cropsToAdd) {
       _plotRepo.addPlot(crop: crop);
    }
  }
  void _clear(StreamController<RecommendationsListViewModel> controller) {
    _cropBasket.empty();
     _update(controller);
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
