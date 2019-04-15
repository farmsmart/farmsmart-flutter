import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';

// We define here generic margins for the app

abstract class CustomAppBar {
  static AppBar build(int currentHomeTab) {
    switch (currentHomeTab) {
      case 0: // MyPlot
        return buildForHome(Strings.myPlotTab, profileAction(), homeIcon() );
        break;
      case 1: // Profit / Loss
        return buildWithTitle(Strings.profitLossTab);
        break;
      case 2: // Articles
        return buildWithTitle(Strings.articlesTab);
        break;
      case 3: // Community
        return buildWithTitle(Strings.communityTab);
        break;
    }
    return AppBar();
  }

  static AppBar buildWithTitle(String title, [Widget profileActions, Widget homeIcon]) {
    return AppBar(
      title: Text(title, style: Styles.appBarTextStyle()));
  }

  static AppBar buildForHome(String title, Widget profileActions, Widget homeIcon) {
    return AppBar(
      leading: homeIcon,
      automaticallyImplyLeading: true, // adds the back button automatically
      title: Text(title, style: Styles.appBarTextStyle()),
      actions: <Widget>[profileActions],
    );
  }

  static Widget profileAction() {
    return IconButton(
        icon: Icon(Icons.account_circle, color: Color(primaryGreen), size: appBarIconSize),
        onPressed: () {});
  }

  static Widget homeIcon() {
    return Image.asset("assets/icons/app_icon.png");
  }
}
