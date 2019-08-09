import 'package:farmsmart_flutter/ui/common/ContextualAppBar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as FlutterWebView;

class _Constants {
  static final loadingIndex = 0;
  static final webViewIndex = 1;
}

class WebView extends StatefulWidget {
  final url;

  const WebView({Key key, this.url}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  int _stackToView;

  @override
  void initState() {
    _stackToView = _Constants.loadingIndex;
    super.initState();
  }

  void _handlePageLoaded(String value) {
    setState(() {
      _stackToView = _Constants.webViewIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _stackToView,
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        Column(
          children: <Widget>[_buildAppbar(context), _buildWebView()],
        )
      ],
    );
  }

  Expanded _buildWebView() {
    return Expanded(
      child: FlutterWebView.WebView(
        initialUrl: widget.url,
        javascriptMode: FlutterWebView.JavascriptMode.unrestricted,
        onPageFinished: _handlePageLoaded,
      ),
    );
  }

  Widget _buildAppbar(BuildContext context) =>
      ContextualAppBar().build(context);
}
