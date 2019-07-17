import 'dart:ui';

import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class _Constants {
  static final EdgeInsets headerEdgePadding = EdgeInsets.only(top: 55, bottom: 20.5);
  static final EdgeInsets detailTextEdgePadding = const EdgeInsets.only(left: 34.6, right: 34.6, bottom: 41);
  static final EdgeInsets actionEdgePadding = const EdgeInsets.only(left: 34, right: 34);
  static final EdgeInsets footerTextEdgePadding = const EdgeInsets.only(left: 30, right: 30, bottom: 17);
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

  const LandingPage(
      {Key key,
      LandingPageViewModel viewModel,
      LandingPageStyle style = _defaultStyle})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildHeader(),
              _buildSubtitle(),
              SizedBox(height: _Constants.subtitleLineSpace),
              _buildDetailText(),
            ],
          ),
          Column(
            children: <Widget>[
              _buildAction(context),
              SizedBox(height: _Constants.actionLineSpace),
              _buildFooter(context),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: _Constants.footerTextEdgePadding,
        child: FlatButton(
          onPressed: () => _onMenuPressed(context),
          child: Text(
            _viewModel.footerText,
            textAlign: TextAlign.center,
            style: _style.footerTextStyle,
            maxLines: _style.footerTextMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Padding _buildAction(BuildContext context) {
    return Padding(
      padding: _Constants.actionEdgePadding,
      child: RoundedButton(
        viewModel: RoundedButtonViewModel(title: _viewModel.actionText,),
        style: RoundedButtonStyle.largeRoundedButtonStyle().copyWith(buttonTextStyle: _style.actionTextStyle)
      ),
    );
  }

  Padding _buildDetailText() {
    return Padding(
      padding: _Constants.detailTextEdgePadding,
      child: Container(
        width: double.infinity,
        child: Text(
          _viewModel.detailText,
          textAlign: TextAlign.center,
          maxLines: _style.detailTextMaxLines,
          overflow: TextOverflow.ellipsis,
          style: _style.detailTextStyle,
        ),
      ),
    );
  }

  Row _buildSubtitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Image.asset(_viewModel.subtitleImage)],
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: _Constants.headerEdgePadding,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Image.asset(_viewModel.headerImage)]),
    );
  }
}

Future _onMenuPressed(BuildContext context) async {
  showModalBottomSheet(
      context: context,
      builder: (widgetBuilder) => ActionSheet(
          viewModel: MockActionSheetViewModel.buildWithCheckBox(),
          style: ActionSheetStyle.defaultStyle()));
}

