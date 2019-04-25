import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:flutter/material.dart';

class MyPlotItemFooter {
  Widget build() {
    return Row(children: <Widget>[
      Padding(
        padding: Margins.leftPaddingSmall(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(Strings.myPlotCurrentStage),
            Text(Strings.myPlotDetails)
          ],
        )
      )
    ]);
  }
}
