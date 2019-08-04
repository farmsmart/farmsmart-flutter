import 'dart:async';

import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/loading_status.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfile.dart';

import '../ViewModelProvider.dart';

class ProfileListProvider
    implements ViewModelProvider<UserProfileViewModel> {
  final ProfileRepositoryInterface _profileRepository;
  UserProfileViewModel _snapshot;
  final StreamController<UserProfileViewModel> _controller =
      StreamController<UserProfileViewModel>.broadcast();

  ProfileListProvider({
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
      _snapshot = _viewModel(status: LoadingStatus.LOADING);
      _snapshot.refresh();
    }
    return _snapshot;
  }

  UserProfileViewModel _viewModelFromModel(
      StreamController controller, List<ProfileEntity> profiles) {
    
    return null;
  }

  UserProfileViewModel _viewModel({LoadingStatus status}) 
  {
    return null;
  }
}