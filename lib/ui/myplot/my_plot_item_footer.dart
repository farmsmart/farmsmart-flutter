import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class MyPlotItemFooter {
  Widget build(goToDetail, goToStage, cropsData) {
    return Row(children: <Widget>[
      Padding(
          padding: Margins.leftPaddingSmall(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildStageCurrentText(cropsData, goToStage),
              Margins.generalHorizontalPadding(),
              _buildGoToDetailText(cropsData, goToDetail)
            ],
          ))
    ]);
  }
}

_buildStageCurrentText(cropsData, goToStage) {
  return GestureDetector(
      onTap: () {
        goToStage(cropsData.stages
            .first); // TODO When tracking is added, select the proper stage
      },
      child:
          Text(Strings.myPlotCurrentStage, style: Styles.subtitleTextStyle()));
}

_buildGoToDetailText(cropsData, goToDetail) {
  return GestureDetector(
      onTap: () {
        goToDetail(cropsData);
      },
      child: Text(Strings.myPlotDetails,
          style: Styles.subtitleTextStyle()));
}
