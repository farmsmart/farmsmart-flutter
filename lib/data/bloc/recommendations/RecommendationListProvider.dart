import 'dart:async';

import 'package:farmsmart_flutter/ui/recommendations/RecommentationsListViewModel.dart';

import '../ViewModelProvider.dart';

class RecommendationListProvider implements ViewModelProvider<RecommendationsListViewModel> {
    RecommendationsListViewModel _snapshot;

  @override
  RecommendationsListViewModel initial() {
    // TODO: implement initial
    return null;
  }

  @override
  StreamController<RecommendationsListViewModel> observe() {
    // TODO: implement observe
    return null;
  }
}