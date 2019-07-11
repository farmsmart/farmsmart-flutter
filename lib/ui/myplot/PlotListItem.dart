import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/ui/common/DogTagStyles.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/ui/common/network_image_from_future.dart';
import 'package:farmsmart_flutter/ui/common/CircularProgress.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';

class PlotListItemViewModel {
  final String title;
  final String subtitle;
  final String detail;

  Function onTap;

  final Future<String> imageUrl;

  PlotListItemViewModel(
      this.title, this.subtitle, this.detail, this.imageUrl, this.onTap);
}

PlotListItemViewModel fromCropEntityToViewModel(
    CropEntity currentCrop, Function goToDetail) {
  //FIXME: Change the mocked data "planting" and "Day 6" with the correct FirebaseData when available
  return PlotListItemViewModel(currentCrop.name ?? Strings.defaultCropNameText,
      "Planting", "Day 6", currentCrop.imageUrl, () => goToDetail(currentCrop));
}

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

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  final double elevation;
  final double imageSize;
  final double headingLineSpace;
  final double detailLineSpace;
  final double imageLineSpace;
  final int maxLineText;

  PlotListItemStyle(
      this.primaryColor,
      this.dividerColor,
      this.edgePadding,
      this.detailTextEdgePadding,
      this.dividerEdgePadding,
      this.detailTextBorderRadius,
      this.titleTextStyle,
      this.subtitleTextStyle,
      this.elevation,
      this.cardEdgePadding,
      this.imageSize,
      this.detailTextBackgroundColor,
      this.detailLineSpace,
      this.headingLineSpace,
      this.overlayColor,
      this.imageLineSpace,
      this.maxLineText);
}

class _DefaultStyle implements PlotListItemStyle {
  final Color primaryColor = const Color(0xff24d900);
  final Color dividerColor = const Color(0xfff5f8fa);
  final Color detailTextBackgroundColor = const Color(0x1425df0c);
  final Color overlayColor = const Color(0x1425df0c);

  final EdgeInsets detailTextEdgePadding =
      const EdgeInsets.only(left: 12, top: 5.5, right: 12, bottom: 5.5);
  final EdgeInsets dividerEdgePadding = const EdgeInsets.only(left: 25.0);
  final EdgeInsets cardEdgePadding = const EdgeInsets.all(0);
  final EdgeInsets edgePadding =
      const EdgeInsets.only(left: 32.0, top: 27.0, right: 32.0, bottom: 27.0);

  final TextStyle subtitleTextStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.w500, color: Color(0xff1a1b46));

  final BorderRadius detailTextBorderRadius =
      const BorderRadius.all(Radius.circular(20.0));

  final double elevation = 0.0;
  final double imageSize = 80.0;
  final double headingLineSpace = 5;
  final double detailLineSpace = 12;
  final double imageLineSpace = 20;
  final int maxLineText = 1;

  const _DefaultStyle();
}

class PlotListItem {
  Widget buildListItem(PlotListItemViewModel viewModel,
      {PlotListItemStyle itemStyle = const _DefaultStyle()}) {
    return GestureDetector(
        onTap: viewModel.onTap,
        child: Card(
            margin: itemStyle.cardEdgePadding,
            elevation: itemStyle.elevation,
            child: Column(children: <Widget>[
              Container(
                  padding: itemStyle.edgePadding,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildMainTextView(viewModel, itemStyle),
                        SizedBox(width: itemStyle.imageLineSpace),
                        //FIXME: This value parameters are hardcoded right now, later should be the current stage number divided by all the stages.
                        CircularProgress(viewModel: CircularProgressViewModel(
                            initialValue: 20, content: _buildPlotImageContent(itemStyle, viewModel.imageUrl)))
                      ])),
              ListDivider.build(),
            ])));
  }

  _buildMainTextView(
      PlotListItemViewModel viewModel, PlotListItemStyle itemStyle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            viewModel.title,
            maxLines: itemStyle.maxLineText,
            overflow: TextOverflow.ellipsis,
            style: itemStyle.titleTextStyle,
          ),
          SizedBox(height: itemStyle.headingLineSpace),
          Text(viewModel.subtitle,
              maxLines: itemStyle.maxLineText,
              overflow: TextOverflow.ellipsis,
              style: itemStyle.subtitleTextStyle),
          SizedBox(height: itemStyle.detailLineSpace),
          DogTag(
              viewModel: DogTagViewModel(title: viewModel.detail),
              style: DogTagStyles.compactStyle())
        ],
      ),
    );
  }

  List<Widget> _buildPlotImageContent(PlotListItemStyle itemStyle, Future<String> imageUrl) {
    List<Widget> listBuilder = [];
    listBuilder.add(
      NetworkImageFromFuture(imageUrl,
          height: itemStyle.imageSize, width: itemStyle.imageSize, fit: BoxFit.cover),
    );
    listBuilder.add(Positioned.fill(
        child: Container(
      color: itemStyle.overlayColor,
    )));
    return listBuilder;
  }
}
