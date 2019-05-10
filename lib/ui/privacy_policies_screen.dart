

import 'dart:convert';

import 'package:farmsmart_flutter/ui/app_bar.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPoliciesScreen extends StatefulWidget {
  @override
  PrivacyPoliciesState createState() {
    return PrivacyPoliciesState();
  }
}

class PrivacyPoliciesState extends State<PrivacyPoliciesScreen> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar.buildWithTitle(Strings.appbarPopUpPolicies),
      body: WebView(
        initialUrl: '',
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _loadHtmlFromAssets();
        },
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString(Assets.PRIVACY_POLICIES_ASSET);
    _controller.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}