
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/AccountEntity.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserToAccountTransformer extends ObjectTransformer<FirebaseUser,AccountEntity> {
  final ProfileRepositoryInterface _profileRepository;

  FirebaseUserToAccountTransformer(this._profileRepository);
  @override
  AccountEntity transform({FirebaseUser from}) {
    return (from == null) ? null : AccountEntity(from.uid, _profileRepository);
  }
}