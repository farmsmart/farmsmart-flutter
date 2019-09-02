import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';

import 'package:farmsmart_flutter/model/entities/TransactionAmount.dart';

import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';
import 'package:farmsmart_flutter/model/repositories/FirestoreList.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';

import '../TransactionRepositoryInterface.dart';
import 'TransactionEntityTransformers.dart';


class _Fields {
  static const transactions = "/transactions";
}

String _identify(TransactionEntity entity) {
  return entity.id;
}

class TransactionRepositoryFirestore extends FireStoreList<TransactionEntity>
    implements TransactionRepositoryInterface {
  final ProfileRepositoryInterface _profileRepository;
  Future<ProfileEntity> _currentProfile;

  TransactionRepositoryFirestore(
    Firestore firestore,
    ProfileRepositoryInterface profileRepository,
  )   : this._profileRepository = profileRepository,
        super(
          firestore,
          TransactionEntityToDocumentTransformer(),
          DocumentToTransactionEntityTransformer(),
          null,
          _identify,
        ) {
    path = _transactionsCollectionPath;
    _profileRepository.observeCurrent().listen((profile) {
      _currentProfile = Future.value(profile);
    });
    _currentProfile = _profileRepository.getCurrent().then((profile) {
      return profile;
    });
  }

  @override
  Future<TransactionAmount> allTimeBalance() {
    // TODO: implement allTimeBalance
    return Future.value(TransactionAmount("0", false));
  }

  @override
  Future<List<TransactionEntity>> getCollection(
      EntityCollection<TransactionEntity> collection) {
    return collection.getEntities();
  }

  @override
  Future<TransactionEntity> getSingle(String uri) {
    // TODO: implement getSingle
    return null;
  }

  @override
  Stream<TransactionEntity> observeSingle(String uri) {
    // TODO: implement observe
    return null;
  }

  @override
  Future<TransactionAmount> thisWeekCosts() {
    // TODO: implement thisWeekCosts
    return null;
  }

  @override
  Future<TransactionAmount> thisWeekSales() {
    // TODO: implement thisWeekSales
    return null;
  }

  Future<String> _transactionsCollectionPath() {
    return _currentProfile.then((profile){
      return profile.uri + _Fields.transactions;
    });
  }
}
