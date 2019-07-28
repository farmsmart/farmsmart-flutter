import 'package:farmsmart_flutter/data/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/LoadableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/RefreshableViewModel.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card_view_model.dart';
import 'package:farmsmart_flutter/ui/crop/viewmodel/CropDetailViewModel.dart';

typedef BoolforIndexFunction = bool Function(int index);
typedef DetailProviderFunction = ViewModelProvider<CropDetailViewModel> Function(int index);

class RecommendationsListViewModel implements RefreshableViewModel, LoadableViewModel{
  static final error = RecommendationsListViewModel(loadingStatus: LoadingStatus.ERROR);
  final String title;
  final LoadingStatus loadingStatus;

  final List<RecommendationCardViewModel> items;
  final Function refresh;
  final Function apply; 
  final Function clear;
  final DetailProviderFunction detailProvider;
  final BoolforIndexFunction isHeroItem;
  final bool canApply;

  RecommendationsListViewModel({
    String title,
    LoadingStatus loadingStatus,
    List<RecommendationCardViewModel> items,
    Function refresh,
    Function apply,
    Function clear,
    DetailProviderFunction detailProvider,
    BoolforIndexFunction isHeroItem, 
    bool canApply,

  })  : this.title = title,
        this.loadingStatus = loadingStatus,
        this.items = items,
        this.refresh = refresh,
        this.apply = apply,
        this.clear = clear,
        this.detailProvider = detailProvider,
        this.isHeroItem = isHeroItem,
        this.canApply = canApply;
}
