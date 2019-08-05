import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/profile/SwitchProfileListProvider.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/mockData/MockUserProfileViewModel.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:farmsmart_flutter/ui/profile/ProfileListItem.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileList.dart';

import '../ViewModelProvider.dart';

class ProfileDetailProvider
    extends ObjectTransformer<ProfileEntity, ProfileViewModel>
    implements ViewModelProvider<ProfileViewModel> {
  final ProfileRepositoryInterface _profileRepository;
  ProfileViewModel _snapshot;
  LoadingStatus _status = LoadingStatus.LOADING;
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
      status: _status,
      username: from?.name ?? "",
      refresh: _update,
      items: list,
      switchProfileProvider: switchProfileProvider,
    );
  }

  void _update() {
    _profileRepository.getCurrent().then((currentProfile) {
      _controller.sink.add(transform(from: currentProfile));
    });
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
