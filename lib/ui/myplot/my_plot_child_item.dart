import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_item_footer.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/box_shadows.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class MyPlotListItem {
  Widget buildListItem(CropEntity cropsData, Function goToDetail, Function goToStage) {
    return Padding(
        padding: Paddings.boxPadding(),
        child: Container(
            decoration: BoxDecoration(
                color: Color(white),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: BoxShadows.plotListItemShadow()),
            child: Column(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                ),
                child: NetworkImageFromFuture(
                  cropsData.imageUrl,
                  height: detailScreenImageHeight,
                  width: detailScreenImageWidth,
                  fit: BoxFit.fitWidth
                ),
              ),
              Padding(
                  padding: Paddings.boxBigPadding(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("TESTING" ?? Strings.myPlotItemDefaultTitle,
                          style: Styles.titleTextStyle()),
                      Margins.generalListSmallMargin(),
                      Text(Strings.myPlotCurrentStagesMOCK),
                      Margins.generalListBigMargin(),
                      MyPlotItemFooter().build(goToDetail, goToStage, cropsData)
                    ],
                  )),
            ])));
  }
}
