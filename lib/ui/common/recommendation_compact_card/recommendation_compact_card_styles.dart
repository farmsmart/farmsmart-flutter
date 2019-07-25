import 'package:farmsmart_flutter/ui/common/recommendation_compact_card/recommendation_compact_card.dart';
import 'package:flutter/widgets.dart';

class RecommendationCompactCardStyles {
  static RecommendationCompactCardStyle buildAddToPlotStyle() =>
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

  static RecommendationCompactCardStyle buildAddedToPlotStyle() =>
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
        overlayColor: const Color(0x1924d900),
        overlayIconHeight: 26,
        overlayIconWidth: 26,
      );

  static RecommendationCompactCardStyle _defaultRecommendationCardStyle =
      RecommendationCompactCardStyle(
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
    imageHeight: 80,
    imageBorderRadius: const BorderRadius.all(Radius.circular(12.0)),
    descriptionMaxLines: 2,
    contentPadding: const EdgeInsets.all(32.0),
    overlayIconWidth: 26,
    overlayIconHeight: 26,
    overlayColor: Color(0x1425df0c),
    overlayIcon: 'assets/icons/tick_large.png',
  );

  static const defaultRoundedButtonStyle = const RoundedButtonStyle(
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
