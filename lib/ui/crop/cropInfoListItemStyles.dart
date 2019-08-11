import 'package:flutter/material.dart';

import 'CropInfoListItem.dart';


class RecommendationDetailListItemStyles {
  static CropInfoListItemStyle build() =>
      CropInfoListItemStyle(
        titleTextStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: Color(0xff4c4e6e),
        ),
        subtitleTextStyle: TextStyle(
          fontSize: 15,
          color: Color(0xff767690),
        ),
        iconSize: 20,
        circleSize: 20,
      );
}
