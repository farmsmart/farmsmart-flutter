import 'package:farmsmart_flutter/redux/home/screens.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:farmsmart_flutter/utils/styles.dart';
import 'package:farmsmart_flutter/ui/discover/discover_detail_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:path/path.dart';
import 'package:package_info/package_info.dart';




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

  static AppBar buildForDetail(String title, Widget shareActions) {
    return AppBar(
      leading: backIcon(),
      automaticallyImplyLeading: true, // adds the back button automatically
      title: Text(title, style: Styles.appBarDetailTextStyle()),
      actions: <Widget>[shareActions],
      centerTitle: true,
    );
  }

  static Widget profileAction() {
    return IconButton(
        icon: Icon(Icons.account_circle, color: Color(primaryGreen), size: appBarIconSize),
        onPressed: () {});
  }

  static Widget shareAction(String articleID) {
    return IconButton(
      icon: Icon(Icons.share, color: Color(primaryGreen), size: appBarIconSize),
      onPressed: ()  async {
        //Future<String> packageName= getPackageInfo();
        String link = buildLink(articleID);
        print (link);
        var response = await FlutterShareMe().shareToSystem(
              msg: link);
          if (response == 'success') {
            print('navigate success');
          }
      },
    );
  }

  static Future<String> getPackageInfo() async {
    //String dynamicUrl = "https://farmsmart.page.link/?link=https://www.farmsmart.co?id="+articleID+"&type=article&apn="+packageName+"&efr=1";

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    //String dynamicUrl = "https://farmsmart.page.link/?link=https://www.farmsmart.co?id="+articleID+"&type=article&apn="+"co.farmsmart.app.dev"+"&efr=1";
    return packageName;
  }

  /*static String buildLink(Future<String> packageName, String articleID) async {
    Future<String> package = packageName;
    String dynamicUrl = await "https://farmsmart.page.link/?link=https://www.farmsmart.co?id="+articleID+"&type=article&apn="+packageName+"&efr=1";
    return dynamicUrl;
  } */

  static String buildLink(String articleID) {
    String dynamicUrl = "https://farmsmart.page.link/?link=https://www.farmsmart.co?id="+articleID+"&type=article&apn="+"co.farmsmart.app.dev"+"&efr=1";
    return dynamicUrl;
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

  static List<String> popUpMenu = <String>[
    Strings.appbarPopUpPolicies
  ];

  static Widget homeIcon() {
    return Image.asset(Assets.APP_ICON);
  }

  static Widget backIcon() {
    return BackButton(color: Color(primaryGreen));
  }
}
