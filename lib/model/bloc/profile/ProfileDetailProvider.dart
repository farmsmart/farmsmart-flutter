import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/profile/SwitchProfileListProvider.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/mockData/MockUserProfileViewModel.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:farmsmart_flutter/ui/profile/ProfileListItem.dart';

import '../ViewModelProvider.dart';

class ProfileDetailProvider
    extends ObjectTransformer<ProfileEntity, ProfileViewModel>
    implements ViewModelProvider<ProfileViewModel> {
  final ProfileRepositoryInterface _profileRepository;
  ProfileViewModel _snapshot;
  LoadingStatus _loadingStatus = LoadingStatus.LOADING;
  final StreamController<ProfileViewModel> _controller =
      StreamController<ProfileViewModel>.broadcast();

  ProfileDetailProvider({
    ProfileRepositoryInterface profileRepo,
  }) : this._profileRepository = profileRepo;

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
        _snapshot = transform(from: currentProfile);
        _controller.sink.add(_snapshot);
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
      switchProfileProvider: switchProfileProvider,
    );
  }

  void _refresh() {
    _profileRepository.getCurrent();
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
