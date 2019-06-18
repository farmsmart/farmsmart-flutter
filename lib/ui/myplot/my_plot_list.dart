import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';

import 'my_plot_page.dart';

abstract class PlotItemStyle {

  final Color primaryColor;
  final Color dividerColor;
  final Color detailTextBackgroundColor;

  final EdgeInsets edgePadding;
  final EdgeInsets detailTextEdgePadding;

  final EdgeInsets dividerEdgePadding;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  final BorderRadius detailTextBorderRadius;

  final TextStyle detailTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;

  final double elevation;
  final double dividerHeight;
  final double imageSize;

  PlotItemStyle(this.primaryColor, this.dividerColor, this.edgePadding,
      this.detailTextEdgePadding, this.dividerEdgePadding,
      this.mainAxisAlignment, this.crossAxisAlignment,
      this.mainAxisSize, this.detailTextBorderRadius, this.detailTextStyle,
      this.titleTextStyle, this.subTitleTextStyle, this.elevation,
      this.dividerHeight,
      this.imageSize, this.detailTextBackgroundColor);
}

class DefaultItemStyle implements PlotItemStyle{

  final Color primaryColor =  const Color(0xff25df0c);
  final Color dividerColor = const Color(0xfff5f8fa);
  final Color detailTextBackgroundColor = const Color(0x1425df0c);


  final EdgeInsets detailTextEdgePadding = const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 5);
  final EdgeInsets dividerEdgePadding = const EdgeInsets.only(left: 25.0);
  final EdgeInsets edgePadding = const EdgeInsets.only(left: 25.0, top: 25.0, right: 30.0, bottom: 25.0);

  final TextStyle subTitleTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle detailTextStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xff25df0c));
  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff1a1b46));

  final MainAxisSize mainAxisSize = MainAxisSize.min;
  final BorderRadius detailTextBorderRadius = const BorderRadius.all(Radius.circular(20.0));

  //FIXME: Maybe we should remove that from style
  final CrossAxisAlignment crossAxisAlignment =   CrossAxisAlignment.start;
  final MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween;

  final double elevation = 0.0;
  final double dividerHeight = 2;
  final double imageSize = 80.0;

  const DefaultItemStyle();
}


class PlotListItem {
  Widget buildListItem(CropListViewModel viewModel, {PlotItemStyle itemStyle = const DefaultItemStyle()}) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Card(
        elevation: itemStyle.elevation,
        child: Column(
          children: <Widget>[
            Container(
              padding: itemStyle.edgePadding,
              child: Row(
                mainAxisAlignment: itemStyle.mainAxisAlignment,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: itemStyle.crossAxisAlignment,
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
                        height: 15,
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
                      padding: itemStyle.detailTextEdgePadding,
                      decoration: BoxDecoration(
                          color: itemStyle.detailTextBackgroundColor,
                          borderRadius: itemStyle.detailTextBorderRadius),
                      child: Row(
                        mainAxisSize: itemStyle.mainAxisSize,
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
        height: itemStyle.dividerHeight,
        color: itemStyle.dividerColor,
        margin: itemStyle.dividerEdgePadding);
  }
}