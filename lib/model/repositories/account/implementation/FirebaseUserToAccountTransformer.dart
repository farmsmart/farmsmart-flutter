
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/AccountEntity.dart';
import 'package:farmsmart_flutter/model/repositories/profile/implementation/MockProfileRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';

final MockProfileRepository _mockProfileRepository =  MockProfileRepository();

class FirebaseUserToAccountTransformer extends ObjectTransformer<FirebaseUser,AccountEntity> {
  @override
  AccountEntity transform({FirebaseUser from}) {
    return (from == null) ? null : AccountEntity(from.uid, _mockProfileRepository);
  }
}