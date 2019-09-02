import 'dart:async';

import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';

import '../ViewModelProvider.dart';

class HomeViewModel implements LoadableViewModel, RefreshableViewModel {
  final LoadingStatus loadingStatus;
  final Function refresh;
  final ProfileRepositoryInterface currentProfile;
  final AccountRepositoryInterface currentAccount;
  final bool debugMenuVisible;

  HomeViewModel(
    this.loadingStatus,
    this.refresh,
    this.currentProfile,
    this.currentAccount,
    this.debugMenuVisible,
  );
}

class HomeViewModelProvider implements ViewModelProvider<HomeViewModel> {
  final AccountRepositoryInterface _accountRepository;
  final StreamController<HomeViewModel> _controller =
      StreamController<HomeViewModel>.broadcast();
  HomeViewModel _snapshot;
  ProfileEntity _lastProfile;
  ProfileRepositoryInterface _profileRepository;
  bool _debugMenuVisible;

  HomeViewModelProvider(
    this._accountRepository,
    this._debugMenuVisible,
  );

  @override
  HomeViewModel initial() {
    if (_snapshot == null) {
      _accountRepository.authorized().then((account) {
        _profileRepository = account.profileRepository;
        account.profileRepository.observeCurrent().listen((currentProfile) {
          final currentProfileID = currentProfile?.uri;
          _snapshot = _viewModel((currentProfileID != null) ? LoadingStatus.SUCCESS : LoadingStatus.LOADING);
          if (_lastProfile?.uri != currentProfileID) {
            _controller.sink.add(_snapshot);
          }
          _lastProfile = currentProfile;
        });
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

  HomeViewModel _viewModel(LoadingStatus status) {
    return HomeViewModel(
      status,
      _refresh,
      _profileRepository,
      _accountRepository,
      _debugMenuVisible,
    );
  }

  void _refresh() {
    _accountRepository.authorized().then((account) {
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
