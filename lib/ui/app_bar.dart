import 'package:farmsmart_flutter/redux/home/screens.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';

// We define here generic margins for the app

abstract class CustomAppBar {
  static AppBar build(int currentHomeTab, Function goToPrivacyPolicy) {
    switch (currentHomeTab) {
      case MY_PLOT_TAB:
        return buildForHome(Strings.myPlotTab, profileAction(), popUpMenuAction(goToPrivacyPolicy), homeIcon());
        break;
      case PROFIT_LOSS_TAB:
        return buildWithTitle(Strings.profitLossTab);
        break;
      case ARTICLES_TAB:
        return buildForHome(Strings.discoverTab, profileAction(), popUpMenuAction(goToPrivacyPolicy), homeIcon());
        break;
      case COMMUNITY_TAB:
        return buildWithTitle(Strings.communityTab);
        break;
    }
    return AppBar();
  }

  static AppBar buildWithTitle(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(title, style: Styles.appBarTextStyle()));
  }

  static AppBar buildForHome(String title, Widget profileActions, Widget privacyAction, Widget homeIcon) {
    return AppBar(
      leading: homeIcon,
      automaticallyImplyLeading: true, // adds the back button automatically
      title: Text(title, style: Styles.appBarTextStyle()),
      actions: <Widget>[profileActions, privacyAction],
      centerTitle: true,
    );
  }

  static AppBar buildForDetail(String title) {
    return AppBar(
      leading: backIcon(),
      automaticallyImplyLeading: true, // adds the back button automatically
      title: Text(title, style: Styles.appBarDetailTextStyle()),
      centerTitle: true,
    );
  }

  static Widget profileAction() {
    return IconButton(
        icon: Icon(Icons.account_circle, color: Color(primaryGreen), size: appBarIconSize),
        onPressed: () {});
  }

  static Widget popUpMenuAction(Function goToPrivacyPolicy) {
    return IconButton(
        icon: PopupMenuButton(onSelected: goToPrivacyPolicy,
          itemBuilder: (BuildContext context) {
            return popUpMenu.map((String action) {
              return PopupMenuItem<String>(
                value: action,
                child: Text(action),
              );
            }).toList();
          },),
        onPressed: () {});
  }

  static const List<String> popUpMenu = const <String>[
    "Privacy Policy"
  ];

  static Widget homeIcon() {
    return Image.asset(Assets.APP_ICON);
  }

  static Widget backIcon() {
    return BackButton(color: Color(primaryGreen));
  }


}
