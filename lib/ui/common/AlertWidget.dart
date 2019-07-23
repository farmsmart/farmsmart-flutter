import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class _Constants {}

class AlertWidgetViewModel {
  String cancelButtonTittle;
  String confirmButtonTittle;
  String titleText;
  String detailText;
  Function acceptAction;
  bool isDestructive;

  AlertWidgetViewModel(
      {@required this.cancelButtonTittle,
      @required this.confirmButtonTittle,
      @required this.titleText,
      this.detailText,
      this.acceptAction,
      this.isDestructive});
}

class AlertWidgetStyle {
  final EdgeInsets alertEdgePadding;
  final BorderRadius cornerRadius;
  final Color backgroundColor;
  final EdgeInsets alertInnerPadding;

  final TextStyle titleTextStyle;
  final double titleLineSpace;
  final TextStyle detailTextStyle;
  final double detailLineSpace;
  final double actionHeight;
  final double actionWidth;
  final BorderRadius actionCornerRadius;
  final Color actionBackgroundColor;
  final Color destructiveActionBackgroundColor;
  final double actionLineSpace;
  final TextStyle actionTextStyle;

  const AlertWidgetStyle({
    this.alertEdgePadding,
    this.cornerRadius,
    this.backgroundColor,
    this.alertInnerPadding,
    this.titleTextStyle,
    this.titleLineSpace,
    this.detailTextStyle,
    this.detailLineSpace,
    this.actionHeight,
    this.actionWidth,
    this.actionCornerRadius,
    this.actionBackgroundColor,
    this.destructiveActionBackgroundColor,
    this.actionLineSpace,
    this.actionTextStyle,
  });

  AlertWidgetStyle copyWith({
    EdgeInsets alertEdgePadding,
    BorderRadius cornerRadius,
    Color backgroundColor,
    EdgeInsets alertInnerPadding,
    TextStyle titleTextStyle,
    double titleLineSpace,
    TextStyle detailTextStyle,
    double detailLineSpace,
    double actionHeight,
    double actionWidth,
    BorderRadius actionCornerRadius,
    Color actionBackgroundColor,
    Color destructiveActionBackgroundColor,
    double actionLineSpace,
    TextStyle actionTextStyle,
  }) {
    return AlertWidgetStyle(
      alertEdgePadding: alertEdgePadding ?? this.alertEdgePadding,
      cornerRadius: cornerRadius ?? this.cornerRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      alertInnerPadding: alertInnerPadding ?? this.alertInnerPadding,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      titleLineSpace: titleLineSpace ?? this.titleLineSpace,
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      detailLineSpace: detailLineSpace ?? this.detailLineSpace,
      actionHeight: actionHeight ?? this.actionHeight,
      actionWidth: actionWidth ?? this.actionWidth,
      actionCornerRadius: actionCornerRadius ?? this.actionCornerRadius,
      actionBackgroundColor: actionBackgroundColor ?? this.actionBackgroundColor,
      destructiveActionBackgroundColor: destructiveActionBackgroundColor ?? this.destructiveActionBackgroundColor,
      actionLineSpace: actionLineSpace ?? this.actionLineSpace,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
    );
  }
}

class _DefaultStyle extends AlertWidgetStyle {
  final alertEdgePadding = const EdgeInsets.symmetric(horizontal: 24);
  final cornerRadius = const BorderRadius.all(Radius.circular(24.0));
  final backgroundColor = const Color(0xffffffff);
  final alertInnerPadding =
      const EdgeInsets.only(left: 32, right: 32, bottom: 31, top: 31);
  final titleTextStyle = const TextStyle(
      color: Color(0xff1a1b46), fontSize: 27, fontWeight: FontWeight.bold);
  final titleLineSpace = 19;
  final detailTextStyle = const TextStyle(
      color: Color(0xff1a1b46),
      fontSize: 17,
      height: 1.1,
      fontWeight: FontWeight.normal);
  final detailLineSpace = 28;
  final actionHeight = 48;
  final actionWidth = 120;
  final actionCornerRadius = const BorderRadius.all(Radius.circular(14));
  final actionBackgroundColor = const Color(0xff24d900);
  final destructiveActionBackgroundColor = const Color(0xffff6060);
  final actionLineSpace = 8;
  final actionTextStyle =
      const TextStyle(color: Color(0xffffffff), fontSize: 15);

  const _DefaultStyle({
    EdgeInsets alertEdgePadding,
    BorderRadius cornerRadius,
    Color backgroundColor,
    EdgeInsets alertInnerPadding,
    TextStyle titleTextStyle,
    double titleLineSpace,
    TextStyle detailTextStyle,
    double detailLineSpace,
    double actionHeight,
    double actionWidth,
    BorderRadius actionCornerRadius,
    Color actionBackgroundColor,
    Color destructiveActionBackgroundColor,
    double actionLineSpace,
    TextStyle actionTextStyle,
  });
}

const AlertWidgetStyle _defaultStyle = const _DefaultStyle();

class AlertWidget extends StatelessWidget {
  final AlertWidgetViewModel _viewModel;
  final AlertWidgetStyle _style;

  const AlertWidget(
      {Key key,
      AlertWidgetViewModel viewModel,
      AlertWidgetStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: _style.cornerRadius,
            color: _style.backgroundColor,
          ),
          child: Padding(
            padding: _style.alertInnerPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _viewModel.titleText,
                  style: _style.titleTextStyle,
                ),
                SizedBox(
                  height: _style.titleLineSpace,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      _viewModel.detailText,
                      style: _style.detailTextStyle,
                    ),
                    SizedBox(
                      height: _style.detailLineSpace,
                    ),
                    Row(
                      children: _buildAction(context),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  confirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertWidget());
  }

  List<Widget> _buildAction(BuildContext context) {
    List<Widget> listBuilder = [
      Expanded(
        child: RoundedButton(
          viewModel: RoundedButtonViewModel(
              title: _viewModel.cancelButtonTittle,
              onTap: () => Navigator.pop(context)),
          style: RoundedButtonStyle.actionSheetLargeRoundedButton().copyWith(
              height: _style.actionHeight,
              width: _style.actionWidth,
              borderRadius: _style.actionCornerRadius),
        ),
      )
    ];
    listBuilder.add(SizedBox(
      width: _style.actionLineSpace,
    ));
    listBuilder.add(Expanded(
      child: RoundedButton(
        viewModel: RoundedButtonViewModel(
            title: _viewModel.confirmButtonTittle, onTap: () {}),
        style: RoundedButtonStyle.actionSheetLargeRoundedButton().copyWith(
            height: _style.actionHeight,
            width: _style.actionWidth,
            backgroundColor: _viewModel.isDestructive
                ? _style.destructiveActionBackgroundColor
                : _style.actionBackgroundColor,
            buttonTextStyle: _style.actionTextStyle,
            borderRadius: _style.actionCornerRadius),
      ),
    ));
    return listBuilder;
  }
}
