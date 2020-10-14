import 'dart:async';

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

class _Constants {
  static final initalBalance = TransactionAmount("0", false);
}

String _getURI(TransactionEntity entity) {
  return entity.uri;
}

class TransactionRepositoryFirestore extends FireStoreList<TransactionEntity>
    implements TransactionRepositoryInterface {
  final ProfileRepositoryInterface _profileRepository;
  Future<ProfileEntity> _currentProfile;
  TransactionAmount _balance;
  StreamSubscription<List<TransactionEntity>> _balanceSubscription;

  TransactionRepositoryFirestore(
    Firestore firestore,
    ProfileRepositoryInterface profileRepository,
  )   : this._profileRepository = profileRepository,
        super(
          firestore,
          TransactionEntityToDocumentTransformer(),
          DocumentToTransactionEntityTransformer(),
          null,
          _getURI,
          orderField: _Fields.orderField,
          orderDecending: true,
        ) {
    path = _transactionsCollectionPath;
    _balance = _Constants.initalBalance;
    _profileRepository.observeCurrent().listen((profile) {
      _currentProfile = Future.value(profile);
    });
    _currentProfile = _profileRepository.getCurrent().then((profile) {
      _balanceSubscription =
          stream().listen((List<TransactionEntity> transactions) {
        return _updateBalance(transactions);
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
      if (profile != null) {
         return profile.uri + _Fields.transactions;
      }
      return null;
    });
  }

  void _updateBalance(List<TransactionEntity> transactions) {
    if(transactions.isEmpty) {
      _balance = _Constants.initalBalance;
      return;
    }
    _balance =
        transactions.map((transaction) => transaction.amount).reduce((a, b) {
      return a + b;
    });
  }

  @override
  void dispose() {
    _balanceSubscription.cancel();
    super.dispose();
  }
}
