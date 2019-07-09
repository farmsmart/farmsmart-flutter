import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Stage { upcoming, inProgress, complete }

class StageStatus {
  Stage stage;
  String stageStatusText;
  String actionText;
  Function actionButton;

  StageStatus({
    this.stage,
    this.stageStatusText,
    this.actionText,
    this.actionButton,
  });
}

class StageCardViewModel {
  String stageNumber;
  String stageTitle;
  StageStatus stageStatus;

  StageCardViewModel({
    this.stageNumber,
    this.stageTitle,
    this.stageStatus
  });
}

abstract class StageCardStyle {
  final double cardCornerRadius;
  final Color cardBackgroundColor;
  final EdgeInsets cardContentPadding;
  final TextStyle stageNumberTextStyle;
  final TextStyle stageTitleTextStyle;

  StageCardStyle(
    this.cardCornerRadius,
    this.cardBackgroundColor,
    this.cardContentPadding,
    this.stageNumberTextStyle,
    this.stageTitleTextStyle,
  );

  StageCardStyle copyWith({
    double cardCornerRadius,
    Color cardBackgroundColor,
    EdgeInsets cardContentPadding,
  });
}

class _DefaultStyle implements StageCardStyle {
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

  const _DefaultStyle(
      {double cardCornerRadius,
      Color cardBackgroundColor,
      EdgeInsets cardContentPadding,
      TextStyle stageNumberTextStyle,
      TextStyle stageTitleTextStyle,});

  @override
  StageCardStyle copyWith({
    double cardCornerRadius,
    Color cardBackgroundColor,
    EdgeInsets cardContentPadding,
    TextStyle stageNumberTextStyle,
    TextStyle stageTitleTextStyle,
  }) {
    return _DefaultStyle(
        cardCornerRadius: cardCornerRadius ?? this.cardCornerRadius,
        cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
        cardContentPadding: cardContentPadding ?? this.cardContentPadding,
        stageNumberTextStyle: stageNumberTextStyle ?? this.stageNumberTextStyle,
        stageTitleTextStyle: stageTitleTextStyle ?? this.stageTitleTextStyle);
  }
}

const StageCardStyle _defaultStyle = const _DefaultStyle();

class StageCard extends StatefulWidget {
  final StageCardViewModel _viewModel;
  final StageCardStyle _style;

  StageCard(
      {Key key,
      @required StageCardViewModel viewModel,
      StageCardStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _StageCardState createState() => _StageCardState();
}

class _StageCardState extends State<StageCard> {
  static RoundedButtonStyle _actionButtonStyle =
      RoundedButtonStyle.defaultStyle().copyWith(
    backgroundColor: Color(0xff24d900),
    borderRadius: BorderRadius.all(Radius.circular(16)),
    edgePadding: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
    buttonTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xffffffff)),
    iconEdgePadding: 5,
    height: 45,
    width: double.infinity,
    buttonIconSize: null,
  );

  RoundedButtonStyle _revertActionButtonStyle = _actionButtonStyle.copyWith(
    backgroundColor: Color(0xffe9eaf2),
    buttonTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xff4c4e6e)),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget._style.cardCornerRadius),
          color: widget._style.cardBackgroundColor),
      child: Padding(
        padding: widget._style.cardContentPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      //TODO replace string by viewModel
                      'Stage 2',
                      style: widget._style.stageNumberTextStyle,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      //TODO replace string by viewModel
                      'Planting',
                      style: widget._style.stageTitleTextStyle,
                    ),
                  ],
                ),
                DogTag(
                  viewModel: DogTagViewModel(
                    title: 'Complete',
                  ),
                  style: DogTagStyle.defaultStyle().copyWith(
                    backgroundColor: Color(0xff24d900),
                    titleTextStyle: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            RoundedButton(
              viewModel: RoundedButtonViewModel(
                  title: 'Revert to In Progress', onTap: () {}),
              style: _actionButtonStyle,
            )
          ],
        ),
      ),
    );
  }
}
