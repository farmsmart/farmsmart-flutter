import 'dart:ui';

import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';

class LandingPageViewModel {
  String title;
  String buttonTitle;
  Image welcomeImage;
  Image titleImage;
  String footerText;

  LandingPageViewModel(this.title, this.buttonTitle, this.welcomeImage,
      this.titleImage, this.footerText);
}

class LandingPageStyle {
  final TextStyle titleTextStyle;
  final TextStyle buttonTextStyle;

  LandingPageStyle({this.titleTextStyle, this.buttonTextStyle});
}

class LandingPage extends StatelessWidget {
  final LandingPageViewModel _viewModel;
  final LandingPageStyle _style;

  const LandingPage(
      {Key key, LandingPageViewModel viewModel, LandingPageStyle style})
      : this._viewModel = viewModel,
        this._style = style,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("Welcome Image")],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("FARMSMART LOGO IMAGE"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("TITLETEXT"),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 34, right: 34),
            child: RoundedButton(
                viewModel: RoundedButtonViewModel(
                    title: "ANZA"),
                style: RoundedButtonStyle.largeRoundedButtonStyle(),),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("LANGUAGE SWITCH"),
            ],
          ),
        ],
      ),
    );
  }
}
