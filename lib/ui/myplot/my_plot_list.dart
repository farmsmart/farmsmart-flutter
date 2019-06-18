import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';

import 'my_plot_page.dart';

abstract class PlotItemStyle {

  final Color primaryColor;
  final Color separatorColor;
  final Color primaryColorWithLowOpacity;

  final EdgeInsets listPadding;
  final EdgeInsets paddingBetweenElements;
  final EdgeInsets detailTextPadding;
  final EdgeInsets roundedShapeSize;

  final EdgeInsets separatorIndent;

  final MainAxisAlignment mainAxisAlignmentSpaceBetween;
  final CrossAxisAlignment crossAxisAlignmentStart;
  final MainAxisSize mainAxisSizeMin;

  final BorderRadius roundedBorderRadius;

  final TextStyle detailTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;

  final double deleteElevation;
  final double opacityOnDetail;
  final double separatorHeight;
  final double imageSize;

  PlotItemStyle(this.primaryColor, this.separatorColor, this.listPadding,
      this.paddingBetweenElements, this.detailTextPadding,
      this.roundedShapeSize, this.separatorIndent,
      this.mainAxisAlignmentSpaceBetween, this.crossAxisAlignmentStart,
      this.mainAxisSizeMin, this.roundedBorderRadius, this.detailTextStyle,
      this.titleTextStyle, this.subTitleTextStyle, this.deleteElevation,
      this.opacityOnDetail, this.separatorHeight,
      this.imageSize, this.primaryColorWithLowOpacity);
}

class DefaultItemStyle implements PlotItemStyle{

  final Color primaryColor =  const Color(0xff25df0c);
  final Color separatorColor = const Color(0xfff5f8fa);
  final Color primaryColorWithLowOpacity = const Color(0x1425df0c);


  final EdgeInsets roundedShapeSize = const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 5);
  final EdgeInsets detailTextPadding = const EdgeInsets.only(bottom: 23);
  final EdgeInsets separatorIndent = const EdgeInsets.only(left: 25.0);
  final EdgeInsets paddingBetweenElements = const EdgeInsets.only(bottom: 30);
  final EdgeInsets listPadding = const EdgeInsets.only(left: 25.0, top: 25.0, right: 30.0, bottom: 25.0);

  final TextStyle subTitleTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle detailTextStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xff25df0c));
  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff1a1b46));

  final MainAxisSize mainAxisSizeMin = MainAxisSize.min;
  final BorderRadius roundedBorderRadius = const BorderRadius.all(Radius.circular(20.0));

  final CrossAxisAlignment crossAxisAlignmentStart =   CrossAxisAlignment.start;
  final MainAxisAlignment mainAxisAlignmentSpaceBetween = MainAxisAlignment.spaceBetween;

  final double opacityOnDetail = 0.08;
  final double deleteElevation = 0.0;
  final double separatorHeight = 2;
  final double imageSize = 80.0;

  const DefaultItemStyle();
}


class PlotListItem {
  Widget buildListItem(CropListViewModel viewModel, {PlotItemStyle itemStyle = const DefaultItemStyle()}) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Card(
        elevation: itemStyle.deleteElevation,
        child: Column(
          children: <Widget>[
            Container(
              padding: itemStyle.listPadding,
              child: Row(
                mainAxisAlignment: itemStyle.mainAxisAlignmentSpaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: itemStyle.crossAxisAlignmentStart,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(viewModel.title ?? Strings.defaultCropNameText,
                              style: itemStyle.titleTextStyle)
                        ]
                      ),
                      SizedBox(
                        height: 12.5,
                      ),
                      Row(
                        children: <Widget>[
                          Text(viewModel.subTitle,
                              style: itemStyle.subTitleTextStyle),
                        ]
                      ),
                      SizedBox(
                        height: 12.5,
                      ),
                      Row(
                        children: <Widget>[
                          _buildDayCountView(itemStyle, viewModel.detail)
                        ]
                      )
                    ]
                  ),
                  Column(
                    children: <Widget>[
                      _buildCropImage(viewModel.imageUrl, itemStyle),
                    ],
                  )
                ]
              )
            ),
            Container(
                child: _buildListSeparator(itemStyle)),
          ]
        )
      )
    );
  }

  Container _buildDayCountView(PlotItemStyle itemStyle, String DayText) {
    return Container(
                      padding: itemStyle.roundedShapeSize,
                      decoration: BoxDecoration(
                          color: itemStyle.primaryColorWithLowOpacity,
                          borderRadius: itemStyle.roundedBorderRadius),
                      child: Row(
                        mainAxisSize: itemStyle.mainAxisSizeMin,
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            child: Text(
                              DayText,
                              style: itemStyle.detailTextStyle,
                            ),
                          ))
                        ],
                      ),
                    );
  }

  ClipOval _buildCropImage(
      Future<String> imageUrl, PlotItemStyle itemStyle) {
    return ClipOval(
      child: NetworkImageFromFuture(imageUrl,
          height: itemStyle.imageSize,
          width: itemStyle.imageSize,
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