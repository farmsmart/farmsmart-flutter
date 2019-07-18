import 'dart:ui';

import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _Constants {
  static final EdgeInsets headerEdgePadding =
  EdgeInsets.only(top: 55, bottom: 20.5);
  static final EdgeInsets detailTextEdgePadding =
  const EdgeInsets.only(left: 34.6, right: 34.6, bottom: 41);
  static final EdgeInsets actionEdgePadding =
  const EdgeInsets.only(left: 34, right: 34);
  static final EdgeInsets footerTextEdgePadding =
  const EdgeInsets.only(left: 30, right: 30, bottom: 17);
  static final double subtitleLineSpace = 12;
  static final double detailTextLineSpace = 53;
  static final double actionLineSpace = 16;
}

class LandingPageViewModel {
  String detailText;
  String actionText;
  String footerText;

  String headerImage;
  String subtitleImage;

  LandingPageViewModel({
    this.detailText,
    this.actionText,
    this.headerImage,
    this.subtitleImage,
    this.footerText,
  });
}

class LandingPageStyle {
  final TextStyle detailTextStyle;
  final TextStyle footerTextStyle;
  final TextStyle actionTextStyle;

  final int detailTextMaxLines;
  final int footerTextMaxLines;

  const LandingPageStyle({
    this.detailTextStyle,
    this.footerTextStyle,
    this.actionTextStyle,
    this.detailTextMaxLines,
    this.footerTextMaxLines,
  });

  LandingPageStyle copyWith({
    TextStyle detailTextStyle,
    TextStyle footerTextStyle,
    TextStyle actionTextStyle,
    int detailTextMaxLines,
    int footerTextMaxLines,
  }) {
    return LandingPageStyle(
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      footerTextStyle: footerTextStyle ?? this.footerTextStyle,
      actionTextStyle: actionTextStyle ?? this.actionTextStyle,
      detailTextMaxLines: detailTextMaxLines ?? this.detailTextMaxLines,
      footerTextMaxLines: footerTextMaxLines ?? this.footerTextMaxLines,
    );
  }
}

class _DefaultStyle extends LandingPageStyle {
  final TextStyle detailTextStyle = const TextStyle(
      fontSize: 17,
      height: 1.1,
      fontWeight: FontWeight.normal,
      color: Color(0xff4c4e6e));
  final TextStyle footerTextStyle = const TextStyle(
      fontWeight: FontWeight.normal, fontSize: 15, color: Color(0xff4c4e6e));
  final TextStyle actionTextStyle = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 17, color: Color(0xffffffff));

  final int detailTextMaxLines = 3;
  final int footerTextMaxLines = 1;

  const _DefaultStyle({
    TextStyle detailTextStyle,
    TextStyle footerTextStyle,
    int detailTextMaxLines,
    int footerTextMaxLines,
  });
}

const LandingPageStyle _defaultStyle = const _DefaultStyle();

class LandingPage extends StatelessWidget {
  final LandingPageViewModel _viewModel;
  final LandingPageStyle _style;

  const LandingPage({Key key,
    LandingPageViewModel viewModel,
    LandingPageStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32, right: 32, top: 38),
      child: Column(
        children: <Widget>[
          Container(
            child: Image.asset(
              _viewModel.headerImage,
              width: double.infinity,
            ),
          ),
          Column(
            children: <Widget>[
              Image.asset(_viewModel.subtitleImage,
              ),
              SizedBox(height: 12,),
              Text(
                _viewModel.detailText,
                style: _style.detailTextStyle,
                maxLines: _style.detailTextMaxLines,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RoundedButton(
                  viewModel: RoundedButtonViewModel(
                      title: _viewModel.actionText, onTap: () {}),
                  style: RoundedButtonStyle.largeRoundedButtonStyle()
                      .copyWith(buttonTextStyle: _style.actionTextStyle),
                ),
              ]
          ),
          Column(
            children: <Widget>[
              FlatButton(
                onPressed: () => _onMenuPressed(context),
                child: Text(
                  _viewModel.footerText,
                  style: _style.footerTextStyle,
                  maxLines: _style.footerTextMaxLines,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        //SizedBox(height: 18,)
        ],
      ),
    );
  }

  Future _onMenuPressed(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (widgetBuilder) =>
            ActionSheet(
                viewModel: MockActionSheetViewModel.buildWithCheckBox(),
                style: ActionSheetStyle.defaultStyle()));
  }
}
