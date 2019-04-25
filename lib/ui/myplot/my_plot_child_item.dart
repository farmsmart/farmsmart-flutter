import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_item_footer.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';

class MyPlotListItem {
  Widget buildListItem(CropEntity cropsData, goToDetail) {
    return GestureDetector(
        onTap: () {
          goToDetail(cropsData);
        },
        child: Padding(
            key: ValueKey(cropsData.name ?? "No Title"),
            padding: Margins.boxSmallPadding(),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Color(primaryGrey))
                ),
                child: Column(children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),),
//                      child: FadeInImage.assetNetwork(image: cropsData.imagePath, placeholder: 'assets/raw/crop_image_mock.png', fit: BoxFit.cover),
                      child: Image.asset('assets/raw/crop_image_mock.png', fit: BoxFit.cover),
                  ),
                  Padding(
                      padding: Margins.boxPadding(),
                      child: Column(
                        children: <Widget>[
                          Text(cropsData.name ?? "No Title"),
                          Text(Strings.myPlotCurrentStagesMOCK),
                          MyPlotItemFooter().build()
                        ],
                      )),
                ]))));
  }
}
