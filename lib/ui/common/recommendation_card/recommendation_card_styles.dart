import 'package:farmsmart_flutter/ui/common/recommendation_card/recommendation_card.dart';
import 'package:flutter/widgets.dart';

class RecommendationCardStyles {
  static RecommendationCardStyle buildAddToPlotStyle() =>
      _defaultRecommendationCardStyle.copyWith(
        rightActionButtonStyle: _defaultRoundedButtonStyle.copyWith(
          backgroundColor: Color(0xff24d900),
          buttonTextStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xffffffff),
          ),
        ),
      );

  static RecommendationCardStyle buildAddedToPlotStyle() =>
      _defaultRecommendationCardStyle.copyWith(
        rightBoxDecoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color(0xffe9eaf2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        rightActionButtonStyle: _defaultRoundedButtonStyle.copyWith(
          backgroundColor: Color(0xffffffff),
          buttonTextStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xff4c4e6e),
          ),
        ),
      );

  static RecommendationCardStyle _defaultRecommendationCardStyle =
      RecommendationCardStyle(
    titleTextStyle: const TextStyle(
      color: Color(0xff1a1b46),
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
    subtitleTextStyle: const TextStyle(
      color: Color(0xff1a1b46),
      fontSize: 17,
    ),
    descriptionTextStyle: const TextStyle(
      color: Color(0xff767690),
      fontSize: 14,
    ),
    leftActionButtonStyle: _defaultRoundedButtonStyle,
    rightActionButtonStyle: _defaultRoundedButtonStyle,
    imageHeight: 152,
    imageBorderRadius: const BorderRadius.all(Radius.circular(12.0)),
    descriptionMaxLines: 2,
    contentPadding: const EdgeInsets.all(32.0),
    addedOverlayColor: const Color(0x1924d900),
    addedIcon: Image(
      image: AssetImage('assets/icons/tick_large.png'),
      width: 54,
      height: 54,
    ),
  );

  static RoundedButtonStyle _defaultRoundedButtonStyle = RoundedButtonStyle(
    backgroundColor: Color(0xffe9eaf2),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    buttonTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff4c4e6e)),
    iconEdgePadding: 5,
    height: 40,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );
}
