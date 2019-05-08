import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_item_footer.dart';
import 'package:farmsmart_flutter/utils/box_shadows.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/assets.dart';

class DiscoveryListItem {
  Widget buildListItem(ArticleEntity articleData, goToArticleDetail) {
    return GestureDetector(
        onTap: () {
          goToArticleDetail(articleData);
        },
        child: Padding(
            key: ValueKey(articleData.title ?? "No Title"),
            padding: Margins.articlePadding(),
            child: Container(
                height: 90,
                child: Row(
                  children: <Widget>[
                    FadeInImage.assetNetwork(
                        image: articleData.imageUrl,
                        placeholder: Assets.IMAGE_PLACE_HOLDER,
                        fit: BoxFit.fill),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(articleData.title ?? "No Title",
                              style: Styles.subtitleTextStyle()),
                          Margins.generalListSmallerMargin(),
                          Text(
                              articleData.summary ??
                                  Strings.myPlotItemDefaultTitle,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.footerTextStyle()),
                          //Margins.generalListSmallMargin(),
                          //MyPlotItemFooter().build()
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Icon(
                              Icons.arrow_forward_ios,
                              color: Color(primaryGrey),
                          )
                          //Margins.generalListSmallMargin(),
                          //MyPlotItemFooter().build()
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                    ),
                  ],
                )),

));
  }
}
