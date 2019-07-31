import 'package:farmsmart_flutter/data/model/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/common/recommendation_detail_listitem/recommendation_detail_listitem.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';

class CropDetailViewModel extends ArticleDetailViewModel {
  
  final List<RecommendationDetailListItemViewModel> infoItems;

  CropDetailViewModel(LoadingStatus loadingStatus, String title, String subtitle, String relatedTitle, String contentLinkTitle, ImageURLProvider image, String body, Future<String> shareLink, String contentLink, List<RecommendationDetailListItemViewModel> infoItems) : this.infoItems = infoItems, super(loadingStatus, title, subtitle, relatedTitle, contentLinkTitle, image, body, shareLink, contentLink);
  CropDetailViewModel.fromArticle(ArticleDetailViewModel articleViewModel, List<RecommendationDetailListItemViewModel> infoItems) : this.infoItems = infoItems, super(articleViewModel.loadingStatus, articleViewModel.title, articleViewModel.subtitle, articleViewModel.relatedTitle, articleViewModel.contentLinkTitle, articleViewModel.image, articleViewModel.body, articleViewModel.shareLink, articleViewModel.contentLink);
}