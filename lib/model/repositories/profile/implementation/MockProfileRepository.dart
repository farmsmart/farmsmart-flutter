import 'dart:async';
import 'dart:math';

import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockProfile.dart';

import '../../MockListRepository.dart';
import '../ProfileRepositoryInterface.dart';

class _Constants {
  static const mockCount = 5;
  static const maxDelayMs = 200;
}

class MockProfileRepository extends MockListRepository<ProfileEntity>
    implements ProfileRepositoryInterface {
  MockProfileRepository._(
    IdentifyEntity<ProfileEntity> identifyEntity,
    List<ProfileEntity> startData,
    ProfileEntity current,
  )   : this._current = current,
        super(
          identifyEntity: identifyEntity,
          startingData: startData,
        );
  final _streamController = StreamController<ProfileEntity>.broadcast();
  ProfileEntity _current;

  factory MockProfileRepository() {
    final identifyEntity = (ProfileEntity profile) {
      return profile.uri;
    };
    final profiles = MockProfile().list(count: _Constants.mockCount);
    return MockProfileRepository._(identifyEntity, profiles, profiles.first);
  }

  @override
  Future<ProfileEntity> getCurrent() {
    return Future.delayed(Duration(milliseconds: Random().nextInt(_Constants.maxDelayMs)), () => _current)
        .then((value) {
          _update();
      return value;
    });
  }

   @override
  Future<ProfileEntity> updateCurrent(ProfileEntity updated) {
    _current = updated;
    return Future.delayed(Duration(milliseconds: Random().nextInt(_Constants.maxDelayMs)), () => _current)
        .then((value) {
          _update();
      return value;
    });
  }

  @override
  Stream<ProfileEntity> observeCurrent() {
    return _streamController.stream;
  }

  @override
  Future<bool> switchTo(ProfileEntity profile) {
    _current = profile;
    _update();
    return Future.value(true);
  }

  void _update() {
    _streamController.sink.add(_current);
  }

  void dispose() {
    _streamController.sink.close();
    _streamController.close();
  }

  @override
  Future<List<ProfileEntity>> get() {
    return getList();
  }

  @override
  Stream<List<ProfileEntity>> stream() {
    return observeList();
  }
}
