import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';

typedef GetList<T> = Future<List<T>> Function();

class ArticleDetailViewModel {
  final LoadingStatus loadingStatus;
  final String title;
  final String subtitle;
  final String relatedTitle;
  final String contentLinkTitle;
  final String contentLinkDescription;
  final String contentLinkIcon;
  final ImageURLProvider image;
  final String body;
  final Future<String> shareLink;
  final String contentLink;
  GetList<ArticleListItemViewModel> getRelated;

  /*
          String deepLink = await buildArticleDeeplink(articleID);
          var response = await FlutterShareMe().shareToSystem(msg: Strings.shareArticleText + deepLink);
  */

  ArticleDetailViewModel(
    this.loadingStatus,
    this.title,
    this.subtitle,
    this.relatedTitle,
    this.contentLinkTitle,
    this.image,
    this.body,
    this.shareLink,
    this.contentLink,
    this.contentLinkDescription,
    this.contentLinkIcon,
  );
}
