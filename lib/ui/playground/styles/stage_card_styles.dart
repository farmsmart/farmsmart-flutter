import 'package:farmsmart_flutter/ui/common/stage_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StageCardStyles {
  static StageCardStyle buildReadyToStartStageStyle() {
    return _defaultStageCardStyle.copyWith(
        actionButtonStyle: _defaultRoundedButtonStyle.copyWith(
          backgroundColor: Color(0xff24d900),
          buttonTextStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xffffffff),
          ),
        ),
        statusTagStyle: _defaultDogTagStyle.copyWith(
          backgroundColor: Color(0xffb7b8c9),
          titleTextStyle: TextStyle(
              color: Color(0xffffffff),
              fontSize: 11,
              fontWeight: FontWeight.bold),
        ),);
  }

  static StageCardStyle buildUpcomingStageStyle() {
    return buildReadyToStartStageStyle().copyWith(actionButtonStyle: _defaultRoundedButtonStyle.copyWith(
          backgroundColor: Color(0xffe9eaf2),
          buttonTextStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xff4c4e6e),
          ),
        ),
        );
  }

  static StageCardStyle buildInProgressStageStyle() {
    return _defaultStageCardStyle.copyWith(
        actionButtonStyle: _defaultRoundedButtonStyle.copyWith(
          backgroundColor: Color(0xff24d900),
          buttonTextStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xffffffff),
          ),
        ),
        statusTagStyle: _defaultDogTagStyle.copyWith(
          backgroundColor: Color(0xffffba00),
          titleTextStyle: TextStyle(
              color: Color(0xffffffff),
              fontSize: 11,
              fontWeight: FontWeight.bold),
        ));
  }

  static StageCardStyle buildCompleteStageStyle() {
    return _defaultStageCardStyle.copyWith(
        actionButtonStyle: _defaultRoundedButtonStyle.copyWith(
          backgroundColor: Color(0xffe9eaf2),
          buttonTextStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xff4c4e6e),
          ),
        ),
        statusTagStyle: _defaultDogTagStyle.copyWith(
          backgroundColor: Color(0xff24d900),
          titleTextStyle: TextStyle(
              color: Color(0xffffffff),
              fontSize: 11,
              fontWeight: FontWeight.bold),
      ), statusIcon: Icons.check);
  }

  static StageCardStyle _defaultStageCardStyle = StageCardStyle(
    cornerRadius: 20.0,
    backgroundColor: Color(0xFFf5f8fa),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    subtitleTextStyle: TextStyle(
      color: Color(0xFF767690),
      fontSize: 15,
    ),
    titleTextStyle: TextStyle(
      color: Color(0xFF1A1B46),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    actionButtonStyle: _defaultRoundedButtonStyle,
    statusTagStyle: _defaultDogTagStyle,
  );

  static RoundedButtonStyle _defaultRoundedButtonStyle = RoundedButtonStyle(
    backgroundColor: Color(0xff24d900),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    buttonTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    iconEdgePadding: 5,
    height: 45,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );

  static DogTagStyle _defaultDogTagStyle = DogTagStyle(
    backgroundColor: Color(0xff24d900),
    iconColor: Color(0xffffffff),
    titleTextStyle: TextStyle(
        color: Color(0xffffffff), fontSize: 11, fontWeight: FontWeight.bold),
    borderRadius: BorderRadius.all(Radius.circular(14.0)),
    edgePadding: EdgeInsets.only(top: 8, right: 12, left: 12, bottom: 8),
    maxLines: 1,
    iconSize: 9,
    spacing: 5.5,
  );
}
