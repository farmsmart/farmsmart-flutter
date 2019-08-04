import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/mockData/MockUserProfileViewModel.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfile.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfileListItem.dart';

import '../ViewModelProvider.dart';

class ProfileDetailProvider extends ObjectTransformer<ProfileEntity,UserProfileViewModel> implements ViewModelProvider<UserProfileViewModel> {
  final ProfileRepositoryInterface _profileRepository;
  UserProfileViewModel _snapshot;
  LoadingStatus _status = LoadingStatus.LOADING;
    final StreamController<UserProfileViewModel> _controller =
      StreamController<UserProfileViewModel>.broadcast();

  ProfileDetailProvider({
    ProfileRepositoryInterface profileRepo,
  }) : this._profileRepository = profileRepo;

  @override
  Stream<UserProfileViewModel> stream() {
    return _controller.stream;
  }

  @override
  UserProfileViewModel snapshot() {
    return _snapshot;
  }

  @override
  UserProfileViewModel initial() {
    if (_snapshot == null) {
      _profileRepository.observeCurrent().listen((currentProfile){
        _controller.sink.add(transform(from: currentProfile));
      });
      _snapshot = transform(from: null);
      _snapshot.refresh();
    }
    return _snapshot;
  }

  @override
  UserProfileViewModel transform({ProfileEntity from}) {
    List<UserProfileListItemViewModel> list = []; //TODO; replace with real items
    for (var i = 0; i < 8; i++) {
      list.add(MockUserProfileListItemViewModel.build(i));
    }
    return UserProfileViewModel(status: _status, username: from?.name ?? "", refresh: _update, items: list);
  }

  void _update() {
    _profileRepository.getCurrent().then((currentProfile){
       _controller.sink.add(transform(from: currentProfile));
    });
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }

}
