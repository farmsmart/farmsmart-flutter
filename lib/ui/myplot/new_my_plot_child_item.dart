import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'my_plot_page.dart';

class MyNewPlotListItem {
  Widget buildListItem(CropEntity cropsData, HomeMyPlotPageStyle myPlotStyle) {

    //FIXME: This variables should be with the cropData, but for the moment are hardcored coz of the CMS Data.
    const DayText = "Day 6";
    const currentStage = "Planting";

    return Column(
      children: <Widget>[
        Container(
          padding: myPlotStyle.listPadding,
          child: Row(
            mainAxisAlignment: myPlotStyle.mainAxisAlignmentSpaceBeetwen,
            children: <Widget>[
              Column(
                crossAxisAlignment: myPlotStyle.crossAxisAlignmentStart,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                          cropsData.name ?? Strings.defaultCropNameText,
                          style: myPlotStyle.cropNameTextStyle),
                      Padding(
                        padding: myPlotStyle.paddingBetweenElements,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                    Text(currentStage, style: myPlotStyle.cropStatusTextStyle),
                    Padding(
                      padding: myPlotStyle.paddingBeforeCropDayCount,
                    )
                  ],
                  ),
                  Row(
                    children: <Widget>[
                    Container(
                      padding: myPlotStyle.paddingForDayCount,
                      decoration: BoxDecoration(
                        color: myPlotStyle.primaryGreen.withOpacity(myPlotStyle.oppacityForDayCount),
                        borderRadius: myPlotStyle.ovalRadiousForDayCount),
                      child: Row(
                        mainAxisSize: myPlotStyle.mainAxisSizeMin,
                       children: <Widget>[
                         Flexible(
                           child: Container(
                             child: Text(
                              DayText,
                              style: myPlotStyle.cropDayTextStyle,
                           ),
                         )
                         )],
                      ),
                    )
                  ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  _buildClipOval(cropsData, myPlotStyle),
                ],
              )
            ],
          ),
        ),
        Container(
            child: buildListSeparator(myPlotStyle)
        ),
      ],
    );
  }

  ClipOval _buildClipOval(CropEntity cropsData, HomeMyPlotPageStyle myPlotStyle) {
    return ClipOval(
                  child: NetworkImageFromFuture(
                      cropsData.imageUrl,
                      height: myPlotStyle.sizeForDayCountShape,
                      width: myPlotStyle.sizeForDayCountShape,
                      fit: BoxFit.cover
                  ),
                );
  }

  Widget buildListSeparator(HomeMyPlotPageStyle myPlotStyle) {
    return Container(
        height: myPlotStyle.separatorHeight,
        color: myPlotStyle.separatorWhite,
        margin: myPlotStyle.separatorIndent
    );
  }

}