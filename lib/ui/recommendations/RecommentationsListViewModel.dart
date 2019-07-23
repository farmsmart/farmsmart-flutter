import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card.dart';

class RecommendationsListViewModel {
  final String title;
  final LoadingStatus loadingStatus;

  final List<RecommendationCardViewModel> itemViewModels;
  final Function update;

  RecommendationsListViewModel({
    String title,
    LoadingStatus status,
    List<RecommendationCardViewModel> itemViewModels,
    Function update,
  })  : this.title = title,
        this.loadingStatus = status,
        this.itemViewModels = itemViewModels,
        this.update = update;
}
