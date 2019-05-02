import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_item_footer.dart';
import 'package:farmsmart_flutter/utils/box_shadows.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class MyPlotListItem {
  Widget buildListItem(CropEntity cropsData, goToDetail) {
    return GestureDetector(
        onTap: () {
          goToDetail(cropsData);
        },
        child: Padding(
            key: ValueKey(cropsData.name ?? "No Title"),
            padding: Margins.boxPadding(),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: BoxShadows.plotListItemShadow()
                ),
                child: Column(
                    children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),),
//                      child: FadeInImage.assetNetwork(image: cropsData.imagePath, placeholder: 'assets/raw/crop_image_mock.png', fit: BoxFit.cover),
                      child: Image.asset('assets/raw/crop_image_mock.png', fit: BoxFit.cover),
                  ),
                  Padding(
                      padding: Margins.boxBigPadding(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(cropsData.name ?? "No Title", style: Styles.titleTextStyle()),
                          Margins.generalListSmallMargin(),
                          Text(Strings.myPlotCurrentStagesMOCK),
                          Margins.generalListBigMargin(),
                          MyPlotItemFooter().build()
                        ],
                      )),
                ]))));
  }
}