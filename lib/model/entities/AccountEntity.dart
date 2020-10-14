import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';

class AccountEntity {
  final String id;
  final ProfileRepositoryInterface profileRepository;
  AccountEntity(this.id, this.profileRepository);
}