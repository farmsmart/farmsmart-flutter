import 'package:farmsmart_flutter/ui/common/rounded_button_stateful.dart';
import 'package:flutter/widgets.dart';

import 'recommendation_card.dart';

class RecommendationCardStyles {
  static RecommendationCardStyle buildStyle() =>
      _defaultRecommendationCardStyle;

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
    leftActionButtonStyle: _defaultLeftActionRoundedButtonStyle,
    rightActionButtonStyle: _defaultRightActionRoundedButtonStyle,
    imageHeight: 152,
    imageBorderRadius: const BorderRadius.all(Radius.circular(12.0)),
    descriptionMaxLines: 2,
    contentPadding: const EdgeInsets.all(32.0),
    overlayIconWidth: 54,
    overlayIconHeight: 54,
    overlayColor: Color(0x1425df0c),
    overlayIcon: 'assets/icons/tick_large.png',
    rightActionBoxDecoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: Color(0xffe9eaf2),
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    addedOverlayColor: Color(0x3325df0c),
  );

  static RoundedButtonStatefulStyle _defaultLeftActionRoundedButtonStyle =
      const RoundedButtonStatefulStyle(
    activeRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xffe9eaf2),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      buttonTextStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xff4c4e6e),
      ),
      iconEdgePadding: 5,
      height: 40,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
    inactiveRoundedButtonStyle: const RoundedButtonStyle(
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
    ),
  );

  static RoundedButtonStatefulStyle _defaultRightActionRoundedButtonStyle =
      const RoundedButtonStatefulStyle(
    activeRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xff24d900),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      buttonTextStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Color(0xffffffff),
      ),
      iconEdgePadding: 5,
      height: 40,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
    inactiveRoundedButtonStyle: const RoundedButtonStyle(
      backgroundColor: Color(0xffffffff),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      buttonTextStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff4c4e6e)),
      iconEdgePadding: 5,
      height: 38,
      width: double.infinity,
      buttonIconSize: null,
      iconButtonColor: Color(0xFFFFFFFF),
      buttonShape: BoxShape.rectangle,
    ),
  );
}
