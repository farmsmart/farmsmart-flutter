import 'package:farmsmart_flutter/model/model/ProfileEntity.dart';
import 'package:farmsmart_flutter/model/repositories/BasicRepositoryInterface.dart';

abstract class ProfileRepositoryInterface implements BasicRepositoryInterface<ProfileEntity> {
    Future<ProfileEntity> getCurrent();
    Stream<ProfileEntity> observeCurrent();
    Future<bool> switchTo(ProfileEntity profile);
    Future<ProfileEntity> add(ProfileEntity profile);
    Future<bool> remove(ProfileEntity profile);
    Future<List<ProfileEntity>> getAll();
}