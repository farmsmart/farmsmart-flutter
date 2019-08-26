import 'dart:async';

import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:flutter/material.dart';

import '../ViewModelProvider.dart';

class HomeViewModel implements LoadableViewModel, RefreshableViewModel {
  final LoadingStatus loadingStatus;
  final Function refresh;
  final ProfileRepositoryInterface currentProfile;
  final bool isDebugBuild;

  HomeViewModel(
      this.loadingStatus, this.refresh, this.currentProfile, this.isDebugBuild);
}

class HomeViewModelProvider implements ViewModelProvider<HomeViewModel> {
  final AccountRepositoryInterface _accountRepository;
  final StreamController<HomeViewModel> _controller =
      StreamController<HomeViewModel>.broadcast();
  HomeViewModel _snapshot;
  ProfileEntity _lastProfile;
  ProfileRepositoryInterface _profileRepository;
  bool _isDebugBuild;

  HomeViewModelProvider(this._accountRepository);

  void init(BuildContext context) {
    _isDebugBuild = !AppConfig.of(context).isProductionBuild();
  }

  @override
  HomeViewModel initial() {
    if (_snapshot == null) {
      _accountRepository.getAuthorized().then(
        (account) {
          _profileRepository = account.profileRepository;

          account.profileRepository.observeCurrent().listen(
            (currentProfile) {
              _snapshot = _viewModel(LoadingStatus.SUCCESS);
              if (_lastProfile != currentProfile) {
                _controller.sink.add(_snapshot);
              }
              _lastProfile = currentProfile;
            },
          );
        },
      );
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

  HomeViewModel _viewModel(LoadingStatus status) {
    return HomeViewModel(status, _refresh, _profileRepository, _isDebugBuild);
  }

  void _refresh() {
    _accountRepository.getAuthorized().then((account) {
      if (account != null) {
        account.profileRepository.getCurrent();
      }
    });
  }

  void dispose() {
    _controller.close();
    _controller.sink.close();
  }
}
