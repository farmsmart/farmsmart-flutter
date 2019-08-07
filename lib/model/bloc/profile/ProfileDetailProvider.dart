import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/plot/PlotStatistics.dart';
import 'package:farmsmart_flutter/model/bloc/profile/SwitchProfileListProvider.dart';
import 'package:farmsmart_flutter/model/model/PlotEntity.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/mockData/MockUserProfileViewModel.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:farmsmart_flutter/ui/profile/ProfileListItem.dart';
import 'package:flutter/widgets.dart';

import '../ViewModelProvider.dart';

class ProfileDetailProvider
    extends ObjectTransformer<ProfileEntity, ProfileViewModel>
    implements ViewModelProvider<ProfileViewModel> {
  final ProfileRepositoryInterface _profileRepository;
  final PlotRepositoryInterface _plotRepository;
  int _activeCrops = 0;
  int _completedCrops =0; 
  ProfileViewModel _snapshot;
  ProfileEntity _currentProfile;
  PlotStatistics _plotStatistics = PlotStatistics();
  LoadingStatus _loadingStatus = LoadingStatus.LOADING;
  final StreamController<ProfileViewModel> _controller =
      StreamController<ProfileViewModel>.broadcast();

  ProfileDetailProvider({
    @required ProfileRepositoryInterface profileRepo,
    @required PlotRepositoryInterface plotRepo,
  }) : this._profileRepository = profileRepo, this._plotRepository = plotRepo;

  @override
  Stream<ProfileViewModel> stream() {
    return _controller.stream;
  }

  @override
  ProfileViewModel snapshot() {
    return _snapshot;
  }

  @override
  ProfileViewModel initial() {
    if (_snapshot == null) {
      _profileRepository.observeCurrent().listen((currentProfile) {
        _loadingStatus = LoadingStatus.SUCCESS;
        _currentProfile = currentProfile;
        _snapshot = transform(from: currentProfile);
        _controller.sink.add(_snapshot);
      });

      _plotRepository.observeFarm().listen((List<PlotEntity> plots){
          _activeCrops = _plotStatistics.activeCount(plots);
          _completedCrops = _plotStatistics.compeletedCount(plots);
          _update();
      });

      _snapshot = transform(from: null);
      _snapshot.refresh();
    }
    return _snapshot;
  }

  @override
  ProfileViewModel transform({ProfileEntity from}) {
    List<ProfileListItemViewModel> list = []; //TODO; replace with real items
    for (var i = 0; i < 8; i++) {
      list.add(MockUserProfileListItemViewModel.build(i));
    }
    final switchProfileProvider =
        SwitchProfileListProvider(profileRepo: _profileRepository);
    return ProfileViewModel(
      loadingStatus: _loadingStatus,
      username: from?.name ?? "",
      refresh: _refresh,
      items: list,
      image: from?.avatar,
      activeCrops: _activeCrops,
      completedCrops: _completedCrops,
      switchProfileProvider: switchProfileProvider,
    );
  }

  void _update() {
      _snapshot = transform(from: _currentProfile);
      _controller.sink.add(_snapshot);
  }

  void _refresh() {
    _profileRepository.getCurrent();
    _plotRepository.getFarm();
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
