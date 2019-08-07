import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'Alert.dart';

export 'package:farmsmart_flutter/ui/common/Dogtag.dart';
export 'package:farmsmart_flutter/ui/common/roundedButton.dart';

class _LocalisedStrings {
  static cancel() => Intl.message('Cancel');

  static confirm() => Intl.message('Confirm');
}

class StageCardViewModel {
  String subtitle;
  String title;
  String actionText;
  String statusTitle;
  Function action;
  StageCardStyle style;
  String dialogTitle;
  String dialogDescription;

  StageCardViewModel({
    this.subtitle,
    this.title,
    this.actionText,
    this.statusTitle,
    this.action,
    this.style,
    this.dialogTitle,
    this.dialogDescription,
  });
}

class StageCardStyle {
  final double cornerRadius;
  final Color backgroundColor;
  final EdgeInsets contentPadding;
  final TextStyle subtitleTextStyle;
  final TextStyle titleTextStyle;
  final RoundedButtonStyle actionButtonStyle;
  final DogTagStyle statusTagStyle;
  final IconData statusIcon;

  const StageCardStyle({
    this.cornerRadius,
    this.backgroundColor,
    this.contentPadding,
    this.subtitleTextStyle,
    this.titleTextStyle,
    this.actionButtonStyle,
    this.statusTagStyle,
    this.statusIcon,
  });

  StageCardStyle copyWith({
    double cornerRadius,
    Color backgroundColor,
    EdgeInsets contentPadding,
    TextStyle subtitleTextStyle,
    TextStyle titleTextStyle,
    RoundedButtonStyle actionButtonStyle,
    DogTagStyle statusTagStyle,
    IconData statusIcon,
  }) {
    return StageCardStyle(
        cornerRadius: cornerRadius ?? this.cornerRadius,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        contentPadding: contentPadding ?? this.contentPadding,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        actionButtonStyle: actionButtonStyle ?? this.actionButtonStyle,
        statusTagStyle: statusTagStyle ?? this.statusTagStyle,
        statusIcon: statusIcon ?? this.statusIcon);
  }
}

class _DefaultStyle extends StageCardStyle {
  final double cornerRadius = 20.0;
  final Color backgroundColor = const Color(0xFFf5f8fa);
  final EdgeInsets contentPadding =
      const EdgeInsets.symmetric(horizontal: 24, vertical: 20);
  final TextStyle subtitleTextStyle = const TextStyle(
    color: Color(0xFF767690),
    fontSize: 15,
  );
  final TextStyle titleTextStyle = const TextStyle(
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
  final DogTagStyle statusTagStyle = const DogTagStyle(
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
    double cornerRadius,
    Color backgroundColor,
    EdgeInsets contentPadding,
    TextStyle subtitleTextStyle,
    TextStyle titleTextStyle,
    RoundedButtonStyle actionButtonStyle,
    DogTagStyle statusTagStyle,
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
          borderRadius: BorderRadius.circular(_style.cornerRadius),
          color: _style.backgroundColor),
      child: Padding(
        padding: _style.contentPadding,
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
                        _viewModel.subtitle,
                        style: _style.subtitleTextStyle,
                        maxLines: _maxLines,
                      ),
                      SizedBox(
                        height: _titleHeightSeparator,
                      ),
                      Text(
                        _viewModel.title,
                        style: _style.titleTextStyle,
                        maxLines: _maxLines,
                      ),
                    ],
                  ),
                ),
                DogTag(
                  viewModel: DogTagViewModel(
                      title: _viewModel.statusTitle, icon: _style.statusIcon),
                  style: _style.statusTagStyle,
                ),
              ],
            ),
            RoundedButton(
              viewModel: RoundedButtonViewModel(
                  title: _viewModel.actionText,
                  onTap: () {
                    _buildAlertAction(context);
                  }),
              style: _style.actionButtonStyle,
            )
          ],
        ),
      ),
    );
  }

  void _buildAlertAction(BuildContext context) {
    if(_viewModel.action != null) {
      Alert.present(
        Alert(
          viewModel: AlertViewModel(
            cancelActionText: _LocalisedStrings.cancel(),
            confirmActionText: _LocalisedStrings.confirm(),
            titleText: _viewModel.dialogTitle,
            detailText: _viewModel.dialogDescription,
            isDestructive: false,
            confirmAction: _viewModel.action,
          ),
        ),
        context,
      );
    }
  }
}
