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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 53, bottom: 31.5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/raw/illustration_welcome.png")
                ],
              ),
            ),
            SizedBox(
              height: 18.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/raw/logo_default.png"),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.only(left: 40, right: 39.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "A network and knowledge source for farmers in Kenya",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: Color(0xff4c4e6e)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 66,
            ),
            Padding(
              padding: EdgeInsets.only(left: 34, right: 34),
              child: RoundedButton(
                viewModel: RoundedButtonViewModel(title: "ANZA"),
                style: RoundedButtonStyle.largeRoundedButtonStyle(),
              ),
            ),
            SizedBox(
              height: 34,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Switch Langauge – Badilisha Lugha", style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Color(0xff4c4e6e)),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
