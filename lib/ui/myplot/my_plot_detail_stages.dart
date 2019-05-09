import 'package:farmsmart_flutter/data/model/stage.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class MyPlotDetailStages {
  Widget build(List<Stage> stagesList) {
    return Column(
        children: (stagesList.map((stage) => buildStageItem(stage))).toList());
  }

  Widget buildStageItem(Stage stage) {
    return Padding(
        padding: Margins.sidesPadding(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(stage.name, style: Styles.detailSubtitleTextStyle()),
            ]));
  }
}
