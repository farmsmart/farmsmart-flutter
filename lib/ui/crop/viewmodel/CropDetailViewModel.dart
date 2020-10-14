import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';

import '../CropInfoListItem.dart';

class CropDetailViewModel extends ArticleDetailViewModel {
  final List<CropInfoListItemViewModel> infoItems;

  CropDetailViewModel(
    LoadingStatus loadingStatus,
    String title,
    String subtitle,
    String relatedTitle,
    String contentLinkTitle,
    ImageURLProvider image,
    String body,
    Future<String> shareLink,
    String contentLink,
    String contentLinkDescription,
    String contentLinkIcon,
    List<CropInfoListItemViewModel> infoItems,
  )   : this.infoItems = infoItems,
        super(
          loadingStatus,
          title,
          subtitle,
          relatedTitle,
          contentLinkTitle,
          image,
          body,
          shareLink,
          contentLink,
          contentLinkDescription,
          contentLinkIcon,
        );

  CropDetailViewModel.fromArticle(ArticleDetailViewModel articleViewModel,
      List<CropInfoListItemViewModel> infoItems)
      : this.infoItems = infoItems,
        super(
          articleViewModel.loadingStatus,
          articleViewModel.title,
          articleViewModel.subtitle,
          articleViewModel.relatedTitle,
          articleViewModel.contentLinkTitle,
          articleViewModel.image,
          articleViewModel.body,
          articleViewModel.shareLink,
          articleViewModel.contentLink,
          articleViewModel.contentLinkDescription,
          articleViewModel.contentLinkIcon,
        );
}
