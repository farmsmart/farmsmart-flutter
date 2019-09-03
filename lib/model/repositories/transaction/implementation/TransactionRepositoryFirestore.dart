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
  static const orderField = "timestamp";
}

String _identify(TransactionEntity entity) {
  return entity.id;
}

class TransactionRepositoryFirestore extends FireStoreList<TransactionEntity>
    implements TransactionRepositoryInterface {
  final ProfileRepositoryInterface _profileRepository;
  Future<ProfileEntity> _currentProfile;
  TransactionAmount _balance;

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
          orderField: _Fields.orderField,
          orderDecending: true,
        ) {
    path = _transactionsCollectionPath;
    _balance = TransactionAmount("0",false);
    _profileRepository.observeCurrent().listen((profile) {
      _currentProfile = Future.value(profile);
    });
    _currentProfile = _profileRepository.getCurrent().then((profile) {
      stream().listen((List<TransactionEntity> transactions) {
      _balance = transactions.map((transaction) => transaction.amount).reduce((a, b) {
        return a + b;
      });
    });
      return profile;
    });
  }

  @override
  Future<TransactionAmount> allTimeBalance() {
    return Future.value(_balance);
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
    return _currentProfile.then((profile) {
      return profile.uri + _Fields.transactions;
    });
  }
}
