import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/model/firebase_const.dart';
import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/article/viewModel/ArticleListItemViewModel.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

/*
      Transform:
      [ArticleEntity] -> [ArticleDetailViewModel]
*/
class _LocalisedStrings {
  static String readTime() => Intl.message('minute read');
}

class _Strings {
  static const divider = " - ";
  static const lessThanMin = "<1";
  static const publishedDateFormat = "d MMMM";
}

class ArticleDetailViewModelTransformer
    extends ObjectTransformer<ArticleEntity, ArticleDetailViewModel> {
  ObjectTransformer<ArticleEntity, ArticleListItemViewModel>
      _listItemTransformer;
  final String _contentLinkTitle;
  final String _relatedTitle;
  final String _contentLinkDescription;
  final String _contentLinkIcon;

  ArticleDetailViewModelTransformer({
    ObjectTransformer<ArticleEntity, ArticleListItemViewModel>
        listItemTransformer,
    String relatedTitle,
    String contentLinkTitle,
    String contentLinkDescription,
    String contentLinkIcon,
  })  : this._listItemTransformer = listItemTransformer,
        this._relatedTitle = relatedTitle,
        this._contentLinkTitle = contentLinkTitle,
        this._contentLinkDescription = contentLinkDescription,
        this._contentLinkIcon = contentLinkIcon;
  final _dateFormatter = DateFormat(_Strings.publishedDateFormat);

  @override
  ArticleDetailViewModel transform({ArticleEntity from}) {
    ArticleImageProvider imageProvider =
        (from.images != null) ? ArticleImageProvider(from) : null;
    final externalLink =
        from.externalLink != null ? from.externalLink.trim() : null;
    ArticleDetailViewModel viewModel = ArticleDetailViewModel(
      LoadingStatus.SUCCESS,
      from.title,
      _subtitle(article: from),
      _relatedTitle,
      _contentLinkTitle,
      imageProvider,
      from.content,
      buildArticleDeeplink(from.uri),
      externalLink,
      _contentLinkDescription,
      _contentLinkIcon,
    );
    viewModel.getRelated = () {
      if (from.related == null) {
        return Future.value([]);
      }
      return from.related.getEntities().then((articles) {
        return articles.map((article) {
          return _listItemTransformer.transform(from: article);
        }).toList();
      });
    };
    return viewModel;
  }

  String _subtitle({ArticleEntity article}) {
    int readMins = _minuteCount(article.content);
    final minString =
        (readMins == 0) ? _Strings.lessThanMin : readMins.toString();
    final dateString = (article.published == null)
        ? ""
        : _dateFormatter.format(article.published);
    return dateString +
        _Strings.divider +
        minString +
        " " +
        _LocalisedStrings.readTime();
  }

  int _minuteCount(String content) {
    final int wordsPerMin = 200;
    final int averageCharsPerWord = 8;
    return content.length ~/ (wordsPerMin * averageCharsPerWord);
  }

  void setListItemTransformer(ArticleListItemViewModelTransformer transformer) {
    _listItemTransformer = transformer;
  }

  //TODO: LH clean this up (model deeplinks in a class) so it can be reused for any type of share
  // just taken from original code for now.

  static Future<String> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    return packageName;
  }

  static Future<String> buildArticleDeeplink(String articleID) async {
    String packageID = await getPackageInfo();

    String dynamicLinkPrefix = DeepLink.Prefix + "/?link=";

    String dynamicLinkBody =
        DeepLink.linkDomain + "?id=" + articleID + "&type=article";
    String dynamicLinkBodyEncoded =
        Uri.encodeComponent(dynamicLinkBody); // To encode url

    String dynamicLinkSufix = "&apn=" + packageID + "&efr=1";

    String fullDynamicLink =
        dynamicLinkPrefix + dynamicLinkBodyEncoded + dynamicLinkSufix;
    return fullDynamicLink;
  }
}
