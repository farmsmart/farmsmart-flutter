import 'dart:convert';

import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// Limitation of WebView
///
/// - Cannot be placed under a scrollable parent together with other widgets unless height is set or fixed.
/// - If height is set, gestures must be enabled for webview.
///
/// - To have free-flowing scroll, it must be the only widget in the composition.
///   Work around for related articles is to use bottom sheets.
///
class ContentWebView extends StatefulWidget {
  final String htmlContent;


  ContentWebView({this.htmlContent});

  @override
  _ContentWebViewState createState() {
    return _ContentWebViewState();
  }
}

class _ContentWebViewState extends State<ContentWebView> {

  @override
  Widget build(BuildContext context) {
    return _buildWebView();
  }

  WebView _buildWebView() {
    return WebView(
      initialUrl: "",
      onWebViewCreated: (WebViewController webViewController) {
        _loadContent(webViewController);
      },
      // Gestures are needed if height is set
//      gestureRecognizers: Set()
//        ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        // prevent all navigation for URLs
        if (request.url.startsWith('http')) {
          print('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
      },
    );
  }

  void _loadContent(WebViewController controller) async {
    // N.B. The inline styles can be modified in the included asset file.
    String template =
        await rootBundle.loadString(Assets.CONTENT_TEMPLATE_ASSET);
    controller.loadUrl(_buildContentUri(template).toString());
  }

  static final placeholder = 'CONTENT_PLACEHOLDER';

  Uri _buildContentUri(String htmlTemplate) {
    return Uri.dataFromString(
        htmlTemplate.replaceAll(placeholder, this.widget.htmlContent),
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'));
  }
}
