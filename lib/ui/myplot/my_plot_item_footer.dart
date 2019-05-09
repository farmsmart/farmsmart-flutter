import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class MyPlotItemFooter {
  Widget build(goToDetail, cropsData) {
    return Row(children: <Widget>[
      Padding(
          padding: Paddings.leftPaddingSmall(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(Strings.myPlotCurrentStage,
                  style: Styles.subtitleTextStyle()),
              Margins.generalHorizontalPadding(),
              GestureDetector(
                  onTap: () {
                    goToDetail(cropsData);
                  },
                  child: Text(Strings.myPlotDetails,
                      style: Styles.subtitleTextStyle()))
            ],
          ))
    ]);
  }
}
