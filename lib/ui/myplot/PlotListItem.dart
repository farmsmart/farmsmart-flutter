import 'package:farmsmart_flutter/model/bloc/ViewModelProvider.dart';
import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/ui/common/CircularProgress.dart';
import 'package:farmsmart_flutter/ui/common/DogTagStyles.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/image_provider_view.dart';
import 'package:farmsmart_flutter/ui/myplot/viewmodel/PlotDetailViewModel.dart';
import 'package:flutter/material.dart';

class PlotListItemViewModel {
  final String title;
  final String subtitle;
  final String detail;
  final double progress;
  final ImageURLProvider imageProvider;
  final ViewModelProvider<PlotDetailViewModel> detailViewModelProvider;

  PlotListItemViewModel(
      {String title,
      String subtitle,
      String detail,
      double progress,
      ImageURLProvider imageProvider,
      ViewModelProvider<PlotDetailViewModel> provider})
      : this.title = title,
        this.subtitle = subtitle,
        this.detail = detail,
        this.progress = progress,
        this.imageProvider = imageProvider,
        this.detailViewModelProvider = provider;
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

  final TextStyle detailTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  final double elevation;
  final double imageSize;
  final double headingLineSpace;
  final double detailLineSpace;
  final double imageLineSpace;
  final int maxLineText;
  final double circularSize;
  final double circularLineWidth;

  PlotListItemStyle(
      this.primaryColor,
      this.dividerColor,
      this.edgePadding,
      this.detailTextEdgePadding,
      this.dividerEdgePadding,
      this.detailTextBorderRadius,
      this.detailTextStyle,
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
      this.maxLineText,
      this.circularSize,
      this.circularLineWidth);
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
      const EdgeInsets.only(left: 32.0, top: 23.5, right: 30.5, bottom: 23.5);

  final TextStyle subtitleTextStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.normal, color: Color(0xff767690));
  final TextStyle detailTextStyle = const TextStyle(
      fontSize: 11, fontWeight: FontWeight.normal, color: Color(0xff25df0c));
  final TextStyle titleTextStyle = const TextStyle(
      fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xff1a1b46));

  final BorderRadius detailTextBorderRadius =
      const BorderRadius.all(Radius.circular(20.0));

  final double elevation = 0.0;
  final double imageSize = 80.0;
  final double headingLineSpace = 5;
  final double detailLineSpace = 11;
  final double imageLineSpace = 20;
  final int maxLineText = 1;
  final double circularSize = 86.5;
  final double circularLineWidth = 2;

  const _DefaultStyle();
}

class _Constants {
  static double dividerThickness = 2;
}

class PlotListItem {
  Widget buildListItem({
    PlotListItemViewModel viewModel,
    Function onTap,
    PlotListItemStyle itemStyle = const _DefaultStyle(),
    bool needDivider = true,
  }) {
    return GestureDetector(
      onTap: onTap,
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
                  _buildMainTextView(viewModel, itemStyle),
                  SizedBox(width: itemStyle.imageLineSpace),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      _buildPlotImage(viewModel.imageProvider, itemStyle),
                      CircularProgress(
                        progress: viewModel.progress,
                        lineWidth: itemStyle.circularLineWidth,
                        size: itemStyle.circularSize,
                      ),
                    ],
                  )
                ],
              ),
            ),
            _buildDivider(itemStyle, needDivider),
          ],
        ),
      ),
    );
  }

  _buildDivider(PlotListItemStyle itemStyle, bool needDivider) {
    return !needDivider
        ? SizedBox.shrink()
        : Container(
            height: _Constants.dividerThickness,
            color: itemStyle.dividerColor,
            margin: itemStyle.dividerEdgePadding,
          );
  }

  _buildMainTextView(
      PlotListItemViewModel viewModel, PlotListItemStyle itemStyle) {
    final titleText = viewModel.title ?? "";
    final subtitleText = viewModel.subtitle ?? "";
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: viewModel.title != null,
            child: Text(
              titleText,
              maxLines: itemStyle.maxLineText,
              overflow: TextOverflow.ellipsis,
              style: itemStyle.titleTextStyle,
            ),
          ),
          SizedBox(height: itemStyle.headingLineSpace),
          Visibility(
            visible: viewModel.subtitle != null,
            child: Text(subtitleText,
                maxLines: itemStyle.maxLineText,
                overflow: TextOverflow.ellipsis,
                style: itemStyle.subtitleTextStyle),
          ),
          SizedBox(height: itemStyle.detailLineSpace),
          DogTag(
              viewModel: DogTagViewModel(title: viewModel.detail),
              style: DogTagStyles.compactStyle())
        ],
      ),
    );
  }

  ClipOval _buildPlotImage(
      ImageURLProvider imageProvider, PlotListItemStyle itemStyle) {
    return ClipOval(
      child: Stack(
        children: <Widget>[
          ImageProviderView(
            imageURLProvider: imageProvider,
            height: itemStyle.imageSize,
            width: itemStyle.imageSize,
          ),
          Positioned.fill(
            child: Container(
              color: itemStyle.overlayColor,
            ),
          ),
        ],
      ),
    );
  }
}
