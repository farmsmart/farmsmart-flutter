import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card.dart';

class RecommendationsListViewModel {
  final String title;
  final LoadingStatus loadingStatus;

  final List<RecommendationCardViewModel> items;
  final Function update;

  RecommendationsListViewModel({
    String title,
    LoadingStatus status,
    List<RecommendationCardViewModel> items,
    Function update,
  })  : this.title = title,
        this.loadingStatus = status,
        this.items = items,
        this.update = update;
}
