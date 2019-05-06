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
    padding: Margins.boxPadding(),
    child: Container(
    height: 80,
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: BoxShadows.plotListItemShadow()),
    child: Row(
    children: <Widget>[
    ClipRRect(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(8.0),
    bottomLeft: Radius.circular(8.0),
    ),
//                      child: FadeInImage.assetNetwork(image: cropsData.imagePath, placeholder: 'assets/raw/crop_image_mock.png', fit: BoxFit.cover),
      child: FadeInImage.assetNetwork(
          image: articleData.imageUrl,
          height: 80,
          width: 80,
          placeholder: Assets.IMAGE_PLACE_HOLDER,
          fit: BoxFit.fill),
    ),
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
          Margins.generalListSmallMargin(),
          Text(articleData.summary ?? Strings.myPlotItemDefaultTitle,
              style: Styles.titleTextStyle()),
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
          Image.asset("assets/icons/profit_loss.png",
            height: 15,
            width: 15,
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
    ))));
  }
}
