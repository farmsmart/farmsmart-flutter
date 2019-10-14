import 'package:farmsmart_flutter/model/bloc/download/OfflineDownloader.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/account/implementation/MockAccountRepository.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/crop/implementation/MockCropRepository.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/profile/implementation/MockProfileRepository.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/RatingEngineRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/implementation/MockRatingEngineRepository.dart';
import 'package:flutter/widgets.dart';
import 'repository_provider.dart';
import 'transaction/TransactionRepositoryInterface.dart';
import 'transaction/implementation/MockTransactionRepository.dart';

ProfileRepositoryInterface _profile = MockProfileRepository();// we won´t Mock account changing (i.e we always have the same account and so profiles)

class MockRepositoryProvider implements RepositoryProvider{

  PlotRepositoryInterface _plot = MockPlotRepository(_profile);
  CropRepositoryInterface _crop = MockCropRepository();
  TransactionRepositoryInterface _trans = MockTransactionRepository(_profile);
  AccountRepositoryInterface _account = MockAccountRepository(_profile);
  RatingEngineRepositoryInterface _ratings = MockRatingEngineRepository();

  init(BuildContext context){
    //ignore
  }
  
  @override
  ArticleRepositoryInterface getArticleRepository() => MockArticlesRepository();

  @override
  PlotRepositoryInterface getMyPlotRepository(ProfileRepositoryInterface profileRepository) => _plot;

  @override
  CropRepositoryInterface getCropRepository() => _crop;

    @override
  TransactionRepositoryInterface getTransactionRepository(ProfileRepositoryInterface profileRepository) => _trans;

  @override
  RatingEngineRepositoryInterface getRatingsRepository() => _ratings;

  @override
  AccountRepositoryInterface getAccountRepository() => _account;

  @override
  OfflineDownloader getDownloader() {
    return OfflineDownloader(getArticleRepository(),getCropRepository(), getRatingsRepository());
  }

}
