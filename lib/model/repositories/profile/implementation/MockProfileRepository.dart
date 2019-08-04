import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/model/mock/MockProfile.dart';

import '../../MockListRepository.dart';
import '../ProfileRepositoryInterface.dart';


class _Constants{
  static const mockCount = 5;
}

class MockProfileRepository extends MockListRepository<ProfileEntity> implements ProfileRepositoryInterface {

   MockProfileRepository._(IdentifyEntity<ProfileEntity> identifyEntity, List<ProfileEntity> startData, ProfileEntity current) : this._current = current, super(identifyEntity: identifyEntity, startingData: startData);

  ProfileEntity _current;

  factory MockProfileRepository() {
    final identifyEntity = (ProfileEntity profile) {
      return profile.id;
    };
    final profiles = MockProfile().list(count: _Constants.mockCount);
    return MockProfileRepository._(identifyEntity, profiles, profiles.first);
  }
  
  @override
  Future<ProfileEntity> getCurrent() {
    return Future.value(_current);
  }

  @override
  Future<bool> switchTo(ProfileEntity profile) {
    _current = profile;
    return Future.value(true);
  }
  

}