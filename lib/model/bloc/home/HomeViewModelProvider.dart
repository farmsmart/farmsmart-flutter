import 'dart:async';

import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';

import '../ViewModelProvider.dart';

class HomeViewModel implements LoadableViewModel, RefreshableViewModel{
  final LoadingStatus loadingStatus;
  final Function refresh;
  HomeViewModel(this.loadingStatus, this.refresh);
}

class HomeViewModelProvider implements ViewModelProvider<HomeViewModel> {
  final ProfileRepositoryInterface _profileRepository;
  final StreamController<HomeViewModel> _controller =
      StreamController<HomeViewModel>.broadcast();
  HomeViewModel _snapshot;
  ProfileEntity _lastProfile;
  HomeViewModelProvider(this._profileRepository);
  @override
  HomeViewModel initial() {
    if (_snapshot == null) {
      _profileRepository.observeCurrent().listen((currentProfile) {
        _snapshot = _viewModel(LoadingStatus.SUCCESS);
        if (_lastProfile != currentProfile) {
          _controller.sink.add(_snapshot);
        }
        _lastProfile = currentProfile;
      });
      _snapshot = _viewModel(LoadingStatus.LOADING);
      _snapshot.refresh();
    }
    return _snapshot;
  }

  @override
  HomeViewModel snapshot() {
    return _snapshot;
  }

  @override
  Stream<HomeViewModel> stream() {
    return _controller.stream;
  }

  HomeViewModel _viewModel(LoadingStatus status){
    return HomeViewModel(status, _refresh);
  }

  void _refresh() {
     _profileRepository.getCurrent();
  }
  void dispose() {
    _controller.close();
    _controller.sink.close();
  }
}
