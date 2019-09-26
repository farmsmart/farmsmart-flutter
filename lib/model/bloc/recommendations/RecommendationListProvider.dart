import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/Basket.dart';
import 'package:farmsmart_flutter/model/bloc/StaticViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/crop/CropDetailTransformer.dart';
import 'package:farmsmart_flutter/model/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/RatingEngineRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_view_model.dart';
import 'package:farmsmart_flutter/ui/recommendations/viewmodel/RecommendationsListViewModel.dart';

import '../ViewModelProvider.dart';
import 'RecommendationCardTransformer.dart';

class _Constants {
  static const inputScale = 10.0;
}

class RecommendationListProvider
    implements ViewModelProvider<RecommendationsListViewModel> {
  final String _title;
  final double _heroThreshold;
  final CropRepositoryInterface _cropRepo;
  final PlotRepositoryInterface _plotRepo;
  final ProfileRepositoryInterface _profileRepo;
  final RatingEngineRepositoryInterface _ratingRepo;
  Basket<CropEntity> _cropBasket;
  List<CropEntity> _crops;
  Map<String, String> _ratingLookup;
  //final UserProfileRepositoryInterface _profileRepo; //we need the current input factors from this.
  final _controller =
      StreamController<RecommendationsListViewModel>.broadcast();

  RecommendationEngine _recommendationBusinessLogic;

  RecommendationsListViewModel _snapshot;
  ProfileEntity _currentProfile;

  RecommendationListProvider({
    String title,
    CropRepositoryInterface cropRepo,
    PlotRepositoryInterface plotRepo,
    ProfileRepositoryInterface profileRepo,
    RatingEngineRepositoryInterface ratingRepo,
    double heroThreshold = 0.8,
  })  : this._title = title,
        this._cropRepo = cropRepo,
        this._plotRepo = plotRepo,
        this._profileRepo = profileRepo,
        this._ratingRepo = ratingRepo,
        this._heroThreshold = heroThreshold;

  @override
  RecommendationsListViewModel initial() {
    if (_snapshot == null) {
      _cropBasket = Basket<CropEntity>(_basketDidChange);
      _snapshot = _viewModel(
        status: LoadingStatus.LOADING,
        items: [],
      );
      _snapshot.refresh();
    }
    return _snapshot;
  }

  @override
  Stream<RecommendationsListViewModel> stream() {
    return _controller.stream;
  }

  @override
  RecommendationsListViewModel snapshot() {
    return _snapshot;
  }

  RecommendationsListViewModel _viewModel({
    LoadingStatus status,
    List<RecommendationCardViewModel> items,
  }) {
    return RecommendationsListViewModel(
      title: _title,
      items: items,
      loadingStatus: status,
      canApply: !_cropBasket.isEmpty(),
      refresh: () => _update(_controller),
      apply: () => _add(_controller),
      clear: () => _clear(_controller),
    );
  }

  RecommendationsListViewModel _modelFromCrops(
      List<CropEntity> crops, Map<String, String> lookup) {
    final transformer = RecommendationCardTransformer(
      engine: _recommendationBusinessLogic,
      plotInfo: _currentProfile.lastPlotInfo,
      ratingLookup: lookup,
      basket: _cropBasket,
      provider: _detailProvider,
      heroThreshold: _heroThreshold,
    );
    List<RecommendationCardViewModel> items = crops.where((crop) {
      return (crop.stageArticles != null);
    }).map((crop) {
      return transformer.transform(from: crop);
    }).toList();
    items.sort((a, b) {
      return b.score.compareTo(a.score);
    });
    return _viewModel(
      status: LoadingStatus.SUCCESS,
      items: items,
    );
  }

  void _basketDidChange(List<CropEntity> old) {
    _snapshot = _modelFromCrops(_crops, _ratingLookup);
    _controller.sink.add(_snapshot);
  }

  void _update(StreamController<RecommendationsListViewModel> controller) {
    controller.sink.add(_viewModel(status: LoadingStatus.LOADING, items: []));
    _cropRepo.get().then((crops) {
      _crops = crops;
      _profileRepo.getCurrent().then((profile) {
        _currentProfile = profile;
        _ratingRepo.getRatingInfo().then((ratingInfo) {
          _ratingRepo.ratingNameLookup().then((lookup) {
            _ratingLookup = lookup;
            _recommendationBusinessLogic = RecommendationEngine(
              inputFactors: RatingInfo.extractScores(ratingInfo),
              inputScale: _Constants.inputScale,
              weightMatrix: RatingInfo.extractWeights(ratingInfo),
            );
            _snapshot = _modelFromCrops(crops, _ratingLookup);
            controller.sink.add(_snapshot);
          });
        });
      });
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

  ViewModelProvider<CropDetailViewModel> _detailProvider(CropEntity crop) {
    final transformer = CropDetailTransformer();
    final cropViewModel = transformer.transform(from: crop);
    final provider =
        StaticViewModelProvider<CropDetailViewModel>(cropViewModel);
    return provider;
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
