import 'package:farmsmart_flutter/ui/common/rounded_button_stateful.dart';
import 'package:flutter/material.dart';

import 'recommendation_detail_card.dart';

class RecommendationDetailCardStyles {
  static RecommendationDetailCardStyle build() {
    return _defaultRecommendationDetailCardStyle;
  }

  static RecommendationDetailCardStyle _defaultRecommendationDetailCardStyle =
      RecommendationDetailCardStyle(
    titleTextStyle: TextStyle(
      color: Color(0xff1a1b46),
      fontSize: 27,
      fontWeight: FontWeight.bold,
    ),
    subtitleTagStyle: _defaultDogTagStyle,
    actionStyle: _defaultActionButtonStyle,
    contentPadding: EdgeInsets.all(32.0),
    imageSize: 80,
    imageRadius: BorderRadius.all(
      Radius.circular(12),
    ),
    imageOverlayWidth: 26,
    imageOverlayHeight: 26,
    imageOverlayColor: Color(0x1425df0c),
    iconAssetOverlay: 'assets/icons/tick_large.png',
    actionBoxDecoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Color(0xffe9eaf2),
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    imageAddedOverlayColor: Color(0x3325df0c),
  );

  static RoundedButtonStatefulStyle _defaultActionButtonStyle =
      RoundedButtonStatefulStyle(
    activeRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xff24d900),
      borderRadius: BorderRadius.all(Radius.circular(12)),
      buttonTextStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Color(0xffffffff),
      ),
      iconEdgePadding: 5,
      height: 45,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
    inactiveRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.all(Radius.circular(12)),
      buttonTextStyle: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xff4c4e6e)),
      iconEdgePadding: 5,
      height: 43,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
  );

  static DogTagStyle _defaultDogTagStyle = DogTagStyle(
    backgroundColor: Color(0x1624d900),
    titleTextStyle: TextStyle(
        color: Color(0xff21c400), fontSize: 11, fontWeight: FontWeight.w500),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    edgePadding: EdgeInsets.only(top: 8.5, right: 12, left: 12, bottom: 8),
    maxLines: 1,
    iconSize: 8,
    spacing: 5.5,
  );
  
}
