import 'package:farmsmart_flutter/data/model/stage.dart';
import 'package:farmsmart_flutter/utils/box_shadows.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class MyPlotDetailStages {
  Widget build(List<Stage> stagesList, goToStageDetail) {
    return Column (
        children: (stagesList != null) ? (stagesList.map((stage) => buildStageItem(stage, goToStageDetail))).toList() : null);
  }

  Widget buildStageItem(Stage stageData, goToStageDetail) {
    return GestureDetector(
        onTap: () {
          goToStageDetail(stageData);
        },
        child: Padding(
          key: ValueKey(stageData.name),
          padding: Paddings.boxSmallPadding(),
          child: Container(
              decoration: BoxDecoration(
                  color: Color(white),
                  border: Border.all(color : Color(primaryGreen)),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: BoxShadows.plotListItemShadow()),
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: Paddings.boxSmallPadding(),
                      ),
                      _buildArticleText(stageData.name, stageData.status.toString()),
                      _buildListIcon(),
                      Padding(
                          padding: Paddings.boxSmallPadding()
                      ),
                    ],
                  ),
                  Padding(
                    padding: Paddings.leftPaddingSmall()
                  ),
                ],
              )),
        ));
  }

  _buildArticleText(String title, String status) {
    return Expanded(
      flex: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title,
              style: Styles.detailSubtitleTextStyle()),
          Margins.generalListMargin(),
          Row (
            children: <Widget>[
              Icon(Icons.check), //TODO Get the proper status icon asset.
              Padding(
                padding: Paddings.leftPaddingSmall(),
              ),
              Text("Complete"), //TODO Get the completion status. Doesn't comes from backend (so far)
            ],
          )
        ],
      ),
    );
  }

  _buildListIcon() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.arrow_forward_ios,
          size: 15,
          color: Color(primaryGreen),
          ),
        ],
      ),
    );
  }
}
