import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleDetailViewModel.dart';
import 'package:farmsmart_flutter/ui/discover/viewModel/ArticleListItemViewModel.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

/*
      Transform:
      [ArticleEntity] -> [ArticleDetailViewModel]
*/
class _Strings {
  static const relatedTitle = "Related Articles";
  static const readTime = "minute read";
  static const divider = " - ";
  static const lessThanMin = "<1";
  static const publishedDateFormat = "d MMMM";
}

class ArticleDetailViewModelTransformer
    implements ObjectTransformer<ArticleEntity, ArticleDetailViewModel> {
  ObjectTransformer<ArticleEntity, ArticleListItemViewModel>
      _listItemTransformer;

  ArticleDetailViewModelTransformer(
      {ObjectTransformer<ArticleEntity, ArticleListItemViewModel>
          listItemTransformer})
      : this._listItemTransformer = listItemTransformer;
  final _dateFormatter = DateFormat(_Strings.publishedDateFormat);
  @override
  ArticleDetailViewModel transform({ArticleEntity from}) {
    ArticleDetailViewModel viewModel = ArticleDetailViewModel(
      LoadingStatus.SUCCESS,
      from.title,
      _subtitle(article: from),
      Intl.message(_Strings.relatedTitle),
      ArticleImageProvider(from),
      from.content,
      buildArticleDeeplink(from.id),
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
        : _dateFormatter.format(article.published.toDate());
    return dateString +
        _Strings.divider +
        minString +
        " " +
        Intl.message(_Strings.readTime);
  }

  int _minuteCount(String content) {
    //TODO: check these values
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
