import 'package:flutter/material.dart';

class PlaygroundView extends StatefulWidget {
  static const double _defaultFontSize = 40;
  static const String _defaultTitle = 'Playground';
  static const String _defaultAllWidgetsTitle = 'All widgets';
  static const _defaultAppBarTitle = Text(
    _defaultTitle,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: _defaultFontSize,
    ),
  );

  final List<Widget> widgetList;
  final Color appBarColor;
  final Widget appBarTitle;
  final String allWidgetsText;

  PlaygroundView(
      {Key key,
      @required this.widgetList,
      this.appBarColor = const Color(0xFF00CD9F),
      this.appBarTitle = _defaultAppBarTitle,
      this.allWidgetsText = _defaultAllWidgetsTitle});

  @override
  _PlaygroundViewState createState() => _PlaygroundViewState();
}

class _PlaygroundViewState extends State<PlaygroundView> {
  static const int _firstIndex = 0;
  static const int _hardcodedItemSize = 1;
  static const String _searchText = 'Search';

  List<Widget> items = [];
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    items.addAll(widget.widgetList);
    super.initState();
  }

  @override
  void dispose() {
    items = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _inputTextField(),
          ),
          Expanded(
            child: _listView(),
          ),
        ],
      ),
    );
  }

  void _filterSearchResults(String query) {
    if (query.isNotEmpty) {
      var filteredItems = items
          .where((widget) =>
              widget.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
      setState(() {
        items.clear();
        items.addAll(filteredItems);
      });
    } else {
      _resetList();
    }
  }

  void _resetList() {
    setState(() {
      items.clear();
      items.addAll(widget.widgetList);
    });
  }

  ListView _listView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length + _hardcodedItemSize,
        itemBuilder: (BuildContext context, int index) {
          if (index == _firstIndex) {
            return _playgroundAllListItem(index, context);
          } else {
            return _playgroundListItem(index - _hardcodedItemSize, context);
          }
        });
  }

  TextField _inputTextField() {
    return TextField(
      onChanged: (value) {
        _filterSearchResults(value);
      },
      controller: editingController,
      decoration: InputDecoration(
        labelText: _searchText,
        hintText: _searchText,
        labelStyle: TextStyle(color: widget.appBarColor),
        prefixIcon: Icon(Icons.search, color: widget.appBarColor),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
  }

  ListTile _playgroundAllListItem(int index, BuildContext context) {
    return ListTile(
      title: Text(widget.allWidgetsText),
      onTap: () {
        _navigateToAllWidgets(context, index);
      },
    );
  }

  ListTile _playgroundListItem(int index, BuildContext context) {
    return ListTile(
      title: Text(items[index].toString()),
      onTap: () {
        _navigateToWidgetDetail(context, index);
      },
    );
  }

  void _navigateToWidgetDetail(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _PlaygroundDetail(
              child: items[index],
              appBarColor: widget.appBarColor,
            ),
      ),
    );
  }

  void _navigateToAllWidgets(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _PlaygroundAllWidgets(
              widgetList: widget.widgetList,
              appBarColor: widget.appBarColor,
              allWidgetsText: widget.allWidgetsText,
            ),
      ),
    );
  }
}

/*
  Playground screen/widget with the detail of the widget (only one selected)
 */

class _PlaygroundDetail extends StatelessWidget {
  static const Color _defaultAppBarColor = Color(0xFF00CD9F);
  final Widget child;
  final Color appBarColor;

  _PlaygroundDetail({
    Key key,
    @required this.child,
    this.appBarColor = _defaultAppBarColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(child.toString()),
      ),
      body: Container(
        child: child,
      ),
    );
  }
}

/*
  Playground screen/widget with a list of all the widgets with its names
 */

class _PlaygroundAllWidgets extends StatelessWidget {
  static const double _fontSize = 30.0;
  static const double _verticalPaddingWidgetTitle = 30.0;
  static const Color _defaultAppBarColor = Color(0xFF00CD9F);
  static const EdgeInsets _defaultTextPadding = EdgeInsets.symmetric(
    vertical: _verticalPaddingWidgetTitle,
  );

  final List<Widget> widgetList;
  final Color appBarColor;
  final String allWidgetsText;

  _PlaygroundAllWidgets(
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
