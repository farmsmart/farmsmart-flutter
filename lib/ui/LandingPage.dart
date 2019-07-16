import 'dart:ui';

import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:flutter/material.dart';

class LandingPageViewModel {
  String detailText;
  String actionText;
  String footerText;

  String headerImage;
  String subtitleImage;

  LandingPageViewModel(
      {this.detailText,
      this.actionText,
      this.headerImage,
      this.subtitleImage,
      this.footerText});
}

class LandingPageStyle {
  final TextStyle detailTextStyle;
  final TextStyle footerTextStyle;

  final EdgeInsets headerEdgePadding;
  final EdgeInsets detailTextEdgePadding;
  final EdgeInsets actionEdgePadding;
  final EdgeInsets footerTextEdgePadding;

  final double subtitleLineSpace;
  final double detailTextLineSpace;
  final double actionLineSpace;
  final int detailTextMaxLines;
  final int footerTextMaxLines;

  const LandingPageStyle({
    this.detailTextStyle,
    this.footerTextStyle,
    this.headerEdgePadding,
    this.detailTextEdgePadding,
    this.actionEdgePadding,
    this.footerTextEdgePadding,
    this.subtitleLineSpace,
    this.detailTextLineSpace,
    this.actionLineSpace,
    this.detailTextMaxLines,
    this.footerTextMaxLines,
  });

  LandingPageStyle copyWith({
    TextStyle detailTextStyle,
    TextStyle footerTextStyle,
    EdgeInsets headerEdgePadding,
    EdgeInsets detailTextEdgePadding,
    EdgeInsets actionEdgePadding,
    EdgeInsets footerTextEdgePadding,
    double subtitleLineSpace,
    double detailTextLineSpace,
    double actionLineSpace,
    int detailTextMaxLines,
    int footerTextMaxLines,
  }) {
    return LandingPageStyle(
      detailTextStyle: detailTextStyle ?? this.detailTextStyle,
      footerTextStyle: footerTextStyle ?? this.footerTextStyle,
      headerEdgePadding: headerEdgePadding ?? this.headerEdgePadding,
      detailTextEdgePadding:
          detailTextEdgePadding ?? this.detailTextEdgePadding,
      actionEdgePadding: actionEdgePadding ?? this.actionEdgePadding,
      footerTextEdgePadding:
          footerTextEdgePadding ?? this.footerTextEdgePadding,
      subtitleLineSpace: subtitleLineSpace ?? this.subtitleLineSpace,
      detailTextLineSpace: detailTextLineSpace ?? this.detailTextLineSpace,
      actionLineSpace: actionLineSpace ?? this.actionLineSpace,
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

  final EdgeInsets headerEdgePadding =
      const EdgeInsets.only(top: 56, bottom: 20.5);
  final EdgeInsets detailTextEdgePadding =
      const EdgeInsets.only(left: 39.75, right: 39.75);
  final EdgeInsets actionEdgePadding =
      const EdgeInsets.only(left: 34, right: 34);
  final EdgeInsets footerTextEdgePadding =
      const EdgeInsets.only(left: 30, right: 30, bottom: 16);

  final double subtitleLineSpace = 13;
  final double detailTextLineSpace = 40;
  final double actionLineSpace = 15;
  final int detailTextMaxLines = 3;
  final int footerTextMaxLines = 1;

  const _DefaultStyle({
    TextStyle detailTextStyle,
    TextStyle footerTextStyle,
    EdgeInsets headerEdgePadding,
    EdgeInsets detailTextEdgePadding,
    EdgeInsets actionEdgePadding,
    EdgeInsets footerTextEdgePadding,
    double subtitleLineSpace,
    double detailTextLineSpace,
    double actionLineSpace,
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildSubtitle(),
            SizedBox(height: _style.subtitleLineSpace),
            _buildDetailText(),
            SizedBox(height: _style.detailTextLineSpace),
            _buildAction(context),
            SizedBox(height: _style.actionLineSpace),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Row _buildFooter(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: _style.footerTextEdgePadding,
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
        ),
      ],
    );
  }

  Padding _buildAction(BuildContext context) {
    return Padding(
      padding: _style.actionEdgePadding,
      child: RoundedButton(
        viewModel: RoundedButtonViewModel(title: _viewModel.actionText),
        style: RoundedButtonStyle.largeRoundedButtonStyle(),
      ),
    );
  }

  Padding _buildDetailText() {
    return Padding(
      padding: _style.detailTextEdgePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              _viewModel.detailText,
              textAlign: TextAlign.center,
              maxLines: _style.detailTextMaxLines,
              overflow: TextOverflow.ellipsis,
              style: _style.detailTextStyle,
            ),
          ),
        ],
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
      padding: _style.headerEdgePadding,
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
