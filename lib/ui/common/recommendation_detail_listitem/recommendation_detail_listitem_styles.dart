import 'package:flutter/material.dart';

import 'recommendation_detail_listitem.dart';

class RecommendationDetailListItemStyles {
  static RecommendationDetailListItemStyle build() =>
      RecommendationDetailListItemStyle(
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
