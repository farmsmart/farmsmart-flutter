import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

abstract class ProfileRepositoryInterface implements BasicRepositoryInterface<ProfileEntity> {
    Future<ProfileEntity> getCurrent();
    Future<ProfileEntity> updateCurrent(ProfileEntity profile);
    Stream<ProfileEntity> observeCurrent();
    Future<bool> switchTo(ProfileEntity profile);
    Future<ProfileEntity> add(ProfileEntity profile);
    Future<bool> remove(ProfileEntity profile);
    Future<List<ProfileEntity>> get();
    Stream<List<ProfileEntity>> stream();
}