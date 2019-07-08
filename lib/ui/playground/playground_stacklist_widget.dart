import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class PlaygroundStackList extends StatelessWidget {
  static const double _fontSize = 30.0;
  static const double _verticalPaddingWidgetTitle = 30.0;
  static const Color _defaultAppBarColor = Color(0xFF9CBD3A);
  static const EdgeInsets _defaultTextPadding = EdgeInsets.symmetric(
    vertical: _verticalPaddingWidgetTitle,
  );

  final List<Widget> widgetList;
  final Color appBarColor;
  final String allWidgetsText;

  PlaygroundStackList(
      {Key key,
        @required this.widgetList,
        this.appBarColor = _defaultAppBarColor,
        this.allWidgetsText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(allWidgetsText),
      ),
      body: ListView.builder(
          itemCount: widgetList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: _defaultTextPadding,
                  child: _widgetNameText(index),
                ),
                widgetList[index],
              ],
            );
          }),
    );
  }

  Text _widgetNameText(int index) {
    return Text(
      widgetList[index].toString(),
      style: TextStyle(
        fontSize: _fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}