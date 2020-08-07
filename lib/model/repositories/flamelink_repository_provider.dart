import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/farmsmart_localizations.dart';
import 'package:farmsmart_flutter/model/bloc/download/OfflineDownloader.dart';
import 'package:farmsmart_flutter/model/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/model/repositories/account/implementation/AccountRepositoryFirebase.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/crop/implementation/CropRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/repositories/locale/locale_repository_interface.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'account/AccountRepositoryInterface.dart';
import 'locale/implementation/locale_repository_flamelink.dart';
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
  LocaleRepositoryInterface _localeRepository;

  init(BuildContext context) {
    final environment = AppConfig.of(context).environment;
    this._fireStore = Firestore.instance;
    this._fireStore.settings(persistenceEnabled: true);
    this._firebaseAuth = FirebaseAuth.instance;
    this._cms = FlameLink(
      store: _fireStore,
      environment: environment,
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
    this._localeRepository = LocaleRepositoryFlameLink(FlameLink(
      store: _fireStore,
      environment: environment,
      locale: FarmsmartLocalizations.defaultLocale.locale,
    ) //WE need the local repo to only use the default local for getting its settings, else we would have the copy the settings for each locale on the CMS
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
    return OfflineDownloader(
        getArticleRepository(), getCropRepository(), getRatingsRepository());
  }

  @override
  LocaleRepositoryInterface getLocaleRepository() => _localeRepository;
}
