import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/repositories/FlameLink.dart';
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

import 'profile/ProfileRepositoryInterface.dart';
import 'profile/implementation/MockProfileRepository.dart';
import 'ratingEngine/RatingEngineRepositoryInterface.dart';
import 'ratingEngine/implementation/MockRatingEngineRepository.dart';
import 'ratingEngine/implementation/RatingEngineRepositoryFireStore.dart';
import 'repository_provider.dart';

class FlameLinkRepositoryProvider implements RepositoryProvider {
  FlameLink _cms;
  Firestore _fireStore;

  Map<String,PlotRepositoryInterface> _plotRepos = {};
  Map<String,TransactionRepositoryInterface> _transactionRepos = {};

  ProfileRepositoryInterface _profile = MockProfileRepository();
  RatingEngineRepositoryInterface _ratings = MockRatingEngineRepository();

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
  PlotRepositoryInterface getMyPlotRepository(String profileID) => _plotRepoFor(profileID);

  @override
  CropRepositoryInterface getCropRepository() => CropRepositoryFlamelink(_cms);

  @override
  TransactionRepositoryInterface getTransactionRepository(String profileID) => _transactionRepoFor(profileID);

  @override
  ProfileRepositoryInterface getProfileRepository() => _profile;

  @override
  RatingEngineRepositoryInterface getRatingsRepository() => RatingEngineRepositoryFirestore(_fireStore);

  PlotRepositoryInterface _plotRepoFor(String profileId){
    if(_plotRepos[profileId] == null){
      _plotRepos[profileId] = MockPlotRepository();
    }
    return _plotRepos[profileId];
  }

  TransactionRepositoryInterface _transactionRepoFor(String profileId){
    if(_transactionRepos[profileId] == null){
      _transactionRepos[profileId] = MockTransactionRepository();
    }
    return _transactionRepos[profileId];
  }
}
