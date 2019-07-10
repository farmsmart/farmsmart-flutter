import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

export 'package:farmsmart_flutter/ui/common/Dogtag.dart';
export 'package:farmsmart_flutter/ui/common/roundedButton.dart';

class StageCardViewModel {
  String stageNumber;
  String stageTitle;
  String actionButtonText;
  String stageStatusTitle;
  Function actionButton;
  IconData dogTagIcon;

  StageCardViewModel(
      {this.stageNumber,
      this.stageTitle,
      this.actionButtonText,
      this.stageStatusTitle,
      this.actionButton,
      this.dogTagIcon});
}

class StageCardStyle {
  final double cardCornerRadius;
  final Color cardBackgroundColor;
  final EdgeInsets cardContentPadding;
  final TextStyle stageNumberTextStyle;
  final TextStyle stageTitleTextStyle;
  final RoundedButtonStyle actionButtonStyle;
  final DogTagStyle stageTagStyle;

  const StageCardStyle({
    this.cardCornerRadius,
    this.cardBackgroundColor,
    this.cardContentPadding,
    this.stageNumberTextStyle,
    this.stageTitleTextStyle,
    this.actionButtonStyle,
    this.stageTagStyle,
  });

  StageCardStyle copyWith(
      {double cardCornerRadius,
      Color cardBackgroundColor,
      EdgeInsets cardContentPadding,
      TextStyle stageNumberTextStyle,
      TextStyle stageTitleTextStyle,
      RoundedButtonStyle actionButtonStyle,
      DogTagStyle stageTagStyle}) {
    return StageCardStyle(
        cardCornerRadius: cardCornerRadius ?? this.cardCornerRadius,
        cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
        cardContentPadding: cardContentPadding ?? this.cardContentPadding,
        stageNumberTextStyle: stageNumberTextStyle ?? this.stageNumberTextStyle,
        stageTitleTextStyle: stageTitleTextStyle ?? this.stageTitleTextStyle,
        actionButtonStyle: actionButtonStyle ?? this.actionButtonStyle,
        stageTagStyle: stageTagStyle ?? this.stageTagStyle);
  }
}

class _DefaultStyle extends StageCardStyle {
  final double cardCornerRadius = 20.0;
  final Color cardBackgroundColor = const Color(0xFFf5f8fa);
  final EdgeInsets cardContentPadding =
      const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
  final TextStyle stageNumberTextStyle = const TextStyle(
    color: Color(0xFF767690),
    fontSize: 15,
  );
  final TextStyle stageTitleTextStyle = const TextStyle(
    color: Color(0xFF1A1B46),
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  final RoundedButtonStyle actionButtonStyle = const RoundedButtonStyle(
    backgroundColor: Color(0xff24d900),
    borderRadius: BorderRadius.all(Radius.circular(16)),
    buttonTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    iconEdgePadding: 5,
    height: 45,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );
  final DogTagStyle stageTagStyle = const DogTagStyle(
    backgroundColor: Color(0xff24d900),
    titleTextStyle: TextStyle(
        color: Color(0xffffffff), fontSize: 11, fontWeight: FontWeight.bold),
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    edgePadding: EdgeInsets.only(top: 8.5, right: 12, left: 12, bottom: 8),
    maxLines: 1,
    iconSize: 8,
    spacing: 5.5,
  );

  const _DefaultStyle({
    double cardCornerRadius,
    Color cardBackgroundColor,
    EdgeInsets cardContentPadding,
    TextStyle stageNumberTextStyle,
    TextStyle stageTitleTextStyle,
    RoundedButtonStyle actionButtonStyle,
    DogTagStyle stageTagStyle,
  });
}

const StageCardStyle _defaultStyle = const _DefaultStyle();

class StageCard extends StatelessWidget {
  static final int _maxLines = 1;
  static final double _titleHeightSeparator = 2;
  static final int _titleFlexValue = 3;
  final StageCardViewModel _viewModel;
  final StageCardStyle _style;

  const StageCard({
    Key key,
    @required StageCardViewModel viewModel,
    StageCardStyle style = _defaultStyle,
  })  : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_style.cardCornerRadius),
          color: _style.cardBackgroundColor),
      child: Padding(
        padding: _style.cardContentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: _titleFlexValue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _viewModel.stageNumber,
                        style: _style.stageNumberTextStyle,
                        maxLines: _maxLines,
                      ),
                      SizedBox(
                        height: _titleHeightSeparator,
                      ),
                      Text(
                        _viewModel.stageTitle,
                        style: _style.stageTitleTextStyle,
                        maxLines: _maxLines,
                      ),
                    ],
                  ),
                ),
                DogTag(
                  viewModel: DogTagViewModel(
                      title: _viewModel.stageStatusTitle,
                      icon: _viewModel.dogTagIcon),
                  style: _style.stageTagStyle,
                ),
              ],
            ),
            RoundedButton(
              viewModel: RoundedButtonViewModel(
                  title: _viewModel.actionButtonText,
                  onTap: _viewModel.actionButton),
              style: _style.actionButtonStyle,
            )
          ],
        ),
      ),
    );
  }
}
