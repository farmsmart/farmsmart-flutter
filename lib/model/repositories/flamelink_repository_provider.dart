import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/download/OfflineDownloader.dart';
import 'package:farmsmart_flutter/model/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/model/repositories/account/implementation/AccountRepositoryFirebase.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/crop/implementation/CropRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'account/AccountRepositoryInterface.dart';
import 'plot/implementation/PlotRepositoryFirestore.dart';
import 'profile/ProfileRepositoryInterface.dart';
import 'profile/implementation/FirebaseProfileRepository.dart';
import 'ratingEngine/RatingEngineRepositoryInterface.dart';
import 'ratingEngine/implementation/RatingEngineRepositoryFireStore.dart';
import 'repository_provider.dart';
import 'transaction/implementation/TransactionRepositoryFirestore.dart';

class FlameLinkRepositoryProvider implements RepositoryProvider {
  FlameLink _cms;
  Firestore _fireStore;
  FirebaseAuth _firebaseAuth;
  ProfileRepositoryInterface _profileRepo;
  PlotRepositoryInterface _plotRepo;
  TransactionRepositoryInterface _transactionRepo;

  init(BuildContext context) {
    this._fireStore = Firestore.instance;
    this._fireStore.settings(persistenceEnabled: true);
    this._firebaseAuth = FirebaseAuth.instance;
    this._cms = FlameLink(
      store: _fireStore,
      environment: AppConfig.of(context).environment,
    );
    this._profileRepo = FirebaseProfileRepository(
      this._fireStore,
      this._firebaseAuth,
    );
    this._plotRepo = PlotRepositoryFireStore(
      this._fireStore,
      this._cms,
      this._profileRepo,
    );
    this._transactionRepo = TransactionRepositoryFirestore(
      this._fireStore,
      this._profileRepo,
    );
  }

  @override
  ArticleRepositoryInterface getArticleRepository() =>
      ArticlesRepositoryFlameLink(_cms);

  @override
  PlotRepositoryInterface getMyPlotRepository(
          ProfileRepositoryInterface profileRepository) =>
      _plotRepo;

  @override
  CropRepositoryInterface getCropRepository() => CropRepositoryFlamelink(_cms);

  @override
  TransactionRepositoryInterface getTransactionRepository(
          ProfileRepositoryInterface profileRepository) =>
      _transactionRepo;

  @override
  AccountRepositoryInterface getAccountRepository() =>
      AccountRepositoryFirebase(_firebaseAuth, _profileRepo);

  @override
  RatingEngineRepositoryInterface getRatingsRepository() =>
      RatingEngineRepositoryFirestore(_cms);

  @override
  OfflineDownloader getDownloader() {
    return OfflineDownloader(getArticleRepository(),getCropRepository(), getRatingsRepository());
  }
}
