import 'package:farmsmart_flutter/model/bloc/download/OfflineDownloader.dart';
import 'package:farmsmart_flutter/model/repositories/account/AccountRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/plot/PlotRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/profile/ProfileRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/RatingEngineRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/transaction/TransactionRepositoryInterface.dart';
import 'package:flutter/material.dart';

import 'crop/CropRepositoryInterface.dart';

abstract class RepositoryProvider {

  init(BuildContext context);

  AccountRepositoryInterface getAccountRepository();

  ArticleRepositoryInterface getArticleRepository();

  PlotRepositoryInterface getMyPlotRepository(ProfileRepositoryInterface profileRepository);

  CropRepositoryInterface  getCropRepository();

  TransactionRepositoryInterface getTransactionRepository(ProfileRepositoryInterface profileRepository);

  RatingEngineRepositoryInterface getRatingsRepository();

  OfflineDownloader getDownloader();
}
