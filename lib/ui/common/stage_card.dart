import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StateCardViewModel {
  String stageNumber;
  String stageTitle;
  String stateStatusText;
  String completeText;
  String activeButtonText;
  String inactiveButtonText;
  Function actionButton;

  StateCardViewModel(
      this.stageNumber,
      this.stageTitle,
      this.stateStatusText,
      this.completeText,
      this.activeButtonText,
      this.inactiveButtonText,
      this.actionButton);
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
      this.stageTitleTextStyle);

  StageCardStyle copyWith(
      {double cardCornerRadius,
      Color cardBackgroundColor,
      EdgeInsets cardContentPadding});
}

class _DefaultStyle implements StageCardStyle {
  final double cardCornerRadius = 20.0;
  final Color cardBackgroundColor = const Color(0xFFf5f8fa);
  final EdgeInsets cardContentPadding = const EdgeInsets.all(16);
  final TextStyle stageNumberTextStyle = const TextStyle(
    color: Color(0xFF767690),
    fontSize: 15,
  );
  final TextStyle stageTitleTextStyle = const TextStyle(
    color: Color(0xFF1A1B46),
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  const _DefaultStyle({
    double cardCornerRadius,
    Color cardBackgroundColor,
    EdgeInsets cardContentPadding,
    TextStyle stageNumberTextStyle,
    TextStyle stageTitleTextStyle,
  });

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
  final StateCardViewModel _viewModel;
  final StageCardStyle _style;

  StageCard(
      {Key key,
      StateCardViewModel viewModel,
      StageCardStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  _StageCardState createState() => _StageCardState();
}

class _StageCardState extends State<StageCard> {
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
          mainAxisSize: MainAxisSize.min,
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
                    Text(
                      //TODO replace string by viewModel
                      'Planting',
                      style: widget._style.stageTitleTextStyle,
                    ),
                  ],
                ),

                //TODO: replace by Dogtag
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      //TODO replace string by viewModel
                      'Completed',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.green),
                ),
              ],
            ),
            //Replace by rounded button well done
            RoundedButton.build(
              context: context,
              //TODO replace string by viewModel
              title: 'Mark as Complete',
              //TODO replace function by viewModel
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
