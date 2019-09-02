import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/chatFlow/FlowCoordinator.dart';
import 'package:farmsmart_flutter/model/bloc/chatFlow/NewProfileFlow.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileList.dart';
import 'package:intl/intl.dart';
import '../ViewModelProvider.dart';
import 'ProfileListItemViewModelTransformer.dart';

class _LocalisedStrings {
  static switchProfile() => Intl.message('Switch profile');
}

class SwitchProfileListProvider
    implements ViewModelProvider<SwitchProfileListViewModel> {
  final AccountRepositoryInterface _accountRepository;
  SwitchProfileListViewModel _snapshot;
  final StreamController<SwitchProfileListViewModel> _controller =
      StreamController<SwitchProfileListViewModel>.broadcast();
  ProfileEntity _currentProfile;
  List<ProfileEntity> _profiles;
  SwitchProfileListProvider({
    AccountRepositoryInterface accountRepo,
  }) : this._accountRepository = accountRepo;

  @override
  Stream<SwitchProfileListViewModel> stream() {
    return _controller.stream;
  }

  @override
  SwitchProfileListViewModel snapshot() {
    return _snapshot;
  }

  @override
  SwitchProfileListViewModel initial() {
    if (_snapshot == null) {
      _accountRepository.observeAuthorized().listen((account){
        account.profileRepository?.stream()?.listen((profiles) {
        _updateViewModel(
          status: LoadingStatus.SUCCESS,
          profiles: profiles,
        );
        });
      });
      
      _snapshot = _viewModel(
        controller: _controller,
        status: LoadingStatus.LOADING,
      );
      _snapshot.refresh();
    }
    return _snapshot;
  }

  void _updateViewModel({
    LoadingStatus status,
    List<ProfileEntity> profiles,
  }) {
    if (profiles != null) {
      _profiles = profiles;
    }
    _snapshot = _viewModel(
        controller: _controller,
        status: LoadingStatus.SUCCESS,
        profiles: _profiles);
    _controller.sink.add(_snapshot);
  }

  SwitchProfileListViewModel _viewModel({
    StreamController controller,
    LoadingStatus status,
    List<ProfileEntity> profiles = const [],
  }) {
    final transformer = SwitchProfileListItemViewModelTransformer(
      _switchTo,
      _currentProfile,
    );
    final listItems = profiles.map((profile) {
      return transformer.transform(from: profile);
    }).toList();
    return SwitchProfileListViewModel(
      title: _LocalisedStrings.switchProfile(),
      actionTitle: _LocalisedStrings.switchProfile(),
      items: listItems,
      newProfileFlow: NewProfileFlowCoordinator(_accountRepository, _onFlowStatusChanged),
      refresh: _refresh,
      loadingStatus: status,
    );
  }

  void _onFlowStatusChanged(FlowCoordinator coordinator) {

  }

  void _switchTo(ProfileEntity profile) {
    _accountRepository.authorized().then((account){
        account.profileRepository.switchTo(profile);
    });
  }

  void _refresh() {
    _accountRepository.authorized().then((account){
      account.profileRepository.getCurrent().then((profile) {
      _currentProfile = profile;
       account.profileRepository.get();
    });
    });
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }

}
