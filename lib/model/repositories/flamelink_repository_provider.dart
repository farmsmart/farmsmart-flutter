import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/model/repositories/account/implementation/MockAccountRepository.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/crop/implementation/CropRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:farmsmart_flutter/flavors/app_config.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/implementation/MockTransactionRepository.dart';
import 'package:flutter/material.dart';

import 'account/AccountRepositoryInterface.dart';
import 'profile/ProfileRepositoryInterface.dart';
import 'profile/implementation/MockProfileRepository.dart';
import 'ratingEngine/RatingEngineRepositoryInterface.dart';
import 'ratingEngine/implementation/RatingEngineRepositoryFireStore.dart';
import 'repository_provider.dart';

MockProfileRepository _mockProfileRepository = MockProfileRepository();
MockPlotRepository _mockPlotRepository = MockPlotRepository(_mockProfileRepository);
AccountRepositoryInterface _mockAccountRepository = MockAccountRepository(_mockProfileRepository);
TransactionRepositoryInterface _mockTransactionRepository = MockTransactionRepository(_mockProfileRepository);
class FlameLinkRepositoryProvider implements RepositoryProvider {
  FlameLink _cms;
  Firestore _fireStore;


  

  init(BuildContext context) {
    this._fireStore = Firestore.instance;
    this._cms = FlameLink(
        store: _fireStore,
        environment: AppConfig.of(context).environment);
  }

  @override
  ArticleRepositoryInterface getArticleRepository() =>
      ArticlesRepositoryFlameLink(_cms);

  //TODO Add My Plot FlameLink Repository
  @override
  PlotRepositoryInterface getMyPlotRepository(ProfileRepositoryInterface profileRepository) => _mockPlotRepository;

  @override
  CropRepositoryInterface getCropRepository() => CropRepositoryFlamelink(_cms);

  @override
  TransactionRepositoryInterface getTransactionRepository(ProfileRepositoryInterface profileRepository) => _mockTransactionRepository;

  @override
  AccountRepositoryInterface getAccountRepository() => _mockAccountRepository;

  @override
  RatingEngineRepositoryInterface getRatingsRepository() => RatingEngineRepositoryFirestore(_fireStore);

}
