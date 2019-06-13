import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';

abstract class PlotItemStyle {

  final Color primaryGreenColor;
  final Color separatorColor;

  final EdgeInsets listPadding;
  final EdgeInsets paddingBetweenElements;
  final EdgeInsets paddingBeforeCropDayCount;
  final EdgeInsets paddingForDayCount;

  final EdgeInsets separatorIndent;

  final MainAxisAlignment mainAxisAlignmentSpaceBeetwen;
  final CrossAxisAlignment crossAxisAlignmentStart;
  final MainAxisSize mainAxisSizeMin;

  final BorderRadius roundedBorderRadius;

  final TextStyle cropDayTextStyle;
  final TextStyle cropNameTextStyle;
  final TextStyle cropStatusTextStyle;

  final double deleteElevation;
  final double oppacityForDayCount;
  final double separatorHeight;
  final double sizeForDayCountShape;

  PlotItemStyle(this.primaryGreenColor, this.separatorColor, this.listPadding,
      this.paddingBetweenElements, this.paddingBeforeCropDayCount,
      this.paddingForDayCount, this.separatorIndent,
      this.mainAxisAlignmentSpaceBeetwen, this.crossAxisAlignmentStart,
      this.mainAxisSizeMin, this.roundedBorderRadius, this.cropDayTextStyle,
      this.cropNameTextStyle, this.cropStatusTextStyle, this.deleteElevation,
      this.oppacityForDayCount, this.separatorHeight,
      this.sizeForDayCountShape);
}

class DefaultItemStyle implements PlotItemStyle{

  final Color primaryGreenColor =  const Color(0xff25df0c);
  final Color separatorColor = const Color(0xfff5f8fa);

  final EdgeInsets paddingForDayCount = const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 5);
  final EdgeInsets paddingBeforeCropDayCount = const EdgeInsets.only(bottom: 23);
  final EdgeInsets separatorIndent = const EdgeInsets.only(left: 25.0);
  final EdgeInsets paddingBetweenElements = const EdgeInsets.only(bottom: 30);
  final EdgeInsets listPadding = const EdgeInsets.only(left: 25.0, top: 25.0, right: 30.0, bottom: 25.0);

  final TextStyle cropStatusTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle cropDayTextStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xff25df0c));
  final TextStyle cropNameTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff1a1b46));

  final MainAxisSize mainAxisSizeMin = MainAxisSize.min;
  final BorderRadius roundedBorderRadius = const BorderRadius.all(Radius.circular(20.0));

  final CrossAxisAlignment crossAxisAlignmentStart =   CrossAxisAlignment.start;
  final MainAxisAlignment mainAxisAlignmentSpaceBeetwen = MainAxisAlignment.spaceBetween;

  final double oppacityForDayCount = 0.08;
  final double deleteElevation = 0.0;
  final double separatorHeight = 2;
  final double sizeForDayCountShape = 80.0;

  const DefaultItemStyle();
}


class PlotListItem {
  Widget buildListItem(CropEntity cropsData, Function goToDetail, {PlotItemStyle itemStyle = const DefaultItemStyle()}) {
    //FIXME: This variables should be with the cropData, but for the moment are hardcored coz of the CMS Data.
    const DayText = "Day 6";
    const currentStage = "Planting";

    return GestureDetector(
      onTap: () => goToDetail(cropsData),
      child: Card(
        //FIXME: Retrieve this MagicNumber
        elevation: itemStyle.deleteElevation,
        child: Column(
          children: <Widget>[
            Container(
              padding: itemStyle.listPadding,
              child: Row(
                mainAxisAlignment: itemStyle.mainAxisAlignmentSpaceBeetwen,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: itemStyle.crossAxisAlignmentStart,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(cropsData.name ?? Strings.defaultCropNameText,
                              style: itemStyle.cropNameTextStyle),
                          Padding(
                            padding: itemStyle.paddingBetweenElements,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(currentStage,
                              style: itemStyle.cropStatusTextStyle),
                          Padding(
                            padding: itemStyle.paddingBeforeCropDayCount,
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          _buildDayCountView(itemStyle, DayText)
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      _buildCropImage(cropsData, itemStyle),
                    ],
                  )
                ],
              ),
            ),
            Container(
                child: _buildListSeparator(itemStyle)),
          ],
        ),
      ),
    );
  }

  Container _buildDayCountView(PlotItemStyle itemStyle, String DayText) {
    return Container(
                      padding: itemStyle.paddingForDayCount,
                      decoration: BoxDecoration(
                          color: itemStyle.primaryGreenColor.withOpacity(itemStyle.oppacityForDayCount),
                          borderRadius: itemStyle.roundedBorderRadius),
                      child: Row(
                        mainAxisSize: itemStyle.mainAxisSizeMin,
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            child: Text(
                              DayText,
                              style: itemStyle.cropDayTextStyle,
                            ),
                          ))
                        ],
                      ),
                    );
  }

  ClipOval _buildCropImage(
      CropEntity cropsData, PlotItemStyle itemStyle) {
    return ClipOval(
      child: NetworkImageFromFuture(cropsData.imageUrl,
          height: itemStyle.sizeForDayCountShape,
          width: itemStyle.sizeForDayCountShape,
          fit: BoxFit.cover),
    );
  }

  Widget _buildListSeparator(PlotItemStyle itemStyle) {
    return Container(
        height: itemStyle.separatorHeight,
        color: itemStyle.separatorColor,
        margin: itemStyle.separatorIndent);
  }
}