import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'my_plot_page.dart';

abstract class PlotListItemStyle {

  final Color primaryColor;
  final Color dividerColor;
  final Color detailTextBackgroundColor;

  //FIXME: temporally color added to the blend
  final Color overlayColor;

  final EdgeInsets edgePadding;
  final EdgeInsets detailTextEdgePadding;

  final EdgeInsets dividerEdgePadding;
  final EdgeInsets cardEdgePadding;
  final BorderRadius detailTextBorderRadius;

  final TextStyle detailTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;

  final double elevation;
  final double dividerHeight;
  final double imageSize;
  final double headingLineSpace;
  final double detailLineSpace;

  PlotListItemStyle(this.primaryColor, this.dividerColor, this.edgePadding,
      this.detailTextEdgePadding, this.dividerEdgePadding,
      this.detailTextBorderRadius, this.detailTextStyle,
      this.titleTextStyle, this.subTitleTextStyle, this.elevation,
      this.dividerHeight,this.cardEdgePadding,
      this.imageSize, this.detailTextBackgroundColor,this.detailLineSpace, this.headingLineSpace, this.overlayColor);
}

class _defaultStyle implements PlotListItemStyle{

  final Color primaryColor =  const Color(0xff25df0c);
  final Color dividerColor = const Color(0xfff5f8fa);
  final Color detailTextBackgroundColor = const Color(0x1425df0c);
  final Color overlayColor = const Color(0x1425df0c);

  final EdgeInsets detailTextEdgePadding = const EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 5);
  final EdgeInsets dividerEdgePadding = const EdgeInsets.only(left: 25.0);
  final EdgeInsets cardEdgePadding = const EdgeInsets.all(0);
  final EdgeInsets edgePadding = const EdgeInsets.only(left: 25.0, top: 25.0, right: 30.0, bottom: 25.0);

  final TextStyle subTitleTextStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle detailTextStyle = const TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xff25df0c));
  final TextStyle titleTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff1a1b46));

  final BorderRadius detailTextBorderRadius = const BorderRadius.all(Radius.circular(20.0));

  final double elevation = 0.0;
  final double dividerHeight = 2;
  final double imageSize = 80.0;
  final double headingLineSpace = 12.5;
  final double detailLineSpace = 15;

  const _defaultStyle();
}

class PlotListItem {
  Widget buildListItem(PlotListViewModel viewModel, {PlotListItemStyle itemStyle = const _defaultStyle()}) {
    return GestureDetector(
      onTap: viewModel.onTap,
      child: Card(
        margin: itemStyle.cardEdgePadding,
        elevation: itemStyle.elevation,
        child: Column(
          children: <Widget>[
            Container(
              padding: itemStyle.edgePadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(viewModel.title,
                              style: itemStyle.titleTextStyle)
                        ]
                      ),
                      SizedBox(
                        height: itemStyle.headingLineSpace,
                      ),
                      Row(
                        children: <Widget>[
                          Text(viewModel.subTitle,
                              style: itemStyle.subTitleTextStyle),
                        ]
                      ),
                      SizedBox(
                        height: itemStyle.detailLineSpace,
                      ),
                      Row(
                        children: <Widget>[
                          _buildDetailTextView(itemStyle, viewModel.detail)
                        ]
                      )
                    ]
                  ),
                  Column(
                    children: <Widget>[
                      _buildPlotImage(viewModel.imageUrl, itemStyle),
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

  Container _buildDetailTextView(PlotListItemStyle itemStyle, String text) {
    return Container(
                      padding: itemStyle.detailTextEdgePadding,
                      decoration: BoxDecoration(
                          color: itemStyle.detailTextBackgroundColor,
                          borderRadius: itemStyle.detailTextBorderRadius),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Flexible(
                              child: Container(
                            child: Text(
                              text,
                              style: itemStyle.detailTextStyle,
                            ),
                          ))
                        ],
                      ),
                    );
  }

  ClipOval _buildPlotImage(
      Future<String> imageUrl, PlotListItemStyle itemStyle) {
    return ClipOval(
      child: Stack(
        children: <Widget>[
          NetworkImageFromFuture(imageUrl,
              height: itemStyle.imageSize,
              width: itemStyle.imageSize,
              fit: BoxFit.cover),
          Positioned.fill(
            child: Container(
              color: itemStyle.overlayColor,
            )
          )
        ]
      )
    );
  }

  Widget _buildListSeparator(PlotListItemStyle itemStyle) {
    return Container(
        height: itemStyle.dividerHeight,
        color: itemStyle.dividerColor,
        margin: itemStyle.dividerEdgePadding);
  }
}