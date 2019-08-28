import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/recommendations/recommendation_card/recommendation_card_view_model.dart';

typedef BoolFunction = bool Function();
typedef DetailProviderFunction = ViewModelProvider<CropDetailViewModel> Function();

class RecommendationsListViewModel implements RefreshableViewModel, LoadableViewModel{
  static final error = RecommendationsListViewModel(loadingStatus: LoadingStatus.ERROR);
  final String title;
  final LoadingStatus loadingStatus;

  final List<RecommendationCardViewModel> items;
  final Function refresh;
  final Function apply; 
  final Function clear;
  final bool canApply;

  RecommendationsListViewModel({
    String title,
    LoadingStatus loadingStatus,
    List<RecommendationCardViewModel> items,
    Function refresh,
    Function apply,
    Function clear,
    bool canApply,

  })  : this.title = title,
        this.loadingStatus = loadingStatus,
        this.items = items,
        this.refresh = refresh,
        this.apply = apply,
        this.clear = clear,
        this.canApply = canApply;
}
