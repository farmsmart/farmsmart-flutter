import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:flutter/material.dart';

class PlaygroundView extends StatefulWidget {
  static const double _defaultFontSize = 40;
  static const String _defaultTitle = 'Playground';
  static const String _defaultAllWidgetsTitle = 'All atoms';
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
  final bool showAtoms;

  PlaygroundView(
      {Key key,
      @required this.widgetList,
      this.appBarColor = const Color(0xFF9CBD3A),
      this.appBarTitle = _defaultAppBarTitle,
      this.allWidgetsText = _defaultAllWidgetsTitle,
      this.showAtoms = true});

  @override
  _PlaygroundViewState createState() => _PlaygroundViewState();
}

class _PlaygroundViewState extends State<PlaygroundView> {
  static const String _searchText = 'Search';
  static const double _searchBorderRadius = 10;
  static const double _searchEdgePadding = 16.0;

  List<Widget> items = [];
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    _initWidgetList();
    super.initState();
  }

  @override
  void dispose() {
    items = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(_searchEdgePadding),
                child: _inputTextField(),
              ),
              Expanded(
                child: _listView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initWidgetList() {
    items.addAll(widget.widgetList);
  }

  void _filterSearchResults(String query) {
    if (query.isNotEmpty) {
      var filteredItems = items
          .where((widget) =>
              widget.toString().toLowerCase().contains(query.toLowerCase()) ||
              ((widget is PlaygroundWidget) &&
                  widget.title.toLowerCase().contains(query.toLowerCase())))
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
      _initWidgetList();
    });
  }

  ListView _listView() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
            return _playgroundListItem(index, context);
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
            borderRadius:
                BorderRadius.all(Radius.circular(_searchBorderRadius))),
      ),
    );
  }

  ListTile _playgroundAllListItem(int index, BuildContext context) {
    return ListTile(
      title: Text(widget.allWidgetsText),
      onTap: () {
        _navigateToNextPlayground(context, index);
      },
    );
  }

  ListTile _playgroundListItem(int index, BuildContext context) {
    if (items[index] is PlaygroundWidget) {
      return ListTile(
        leading: Icon(Icons.view_compact),
        title: Text((items[index] as PlaygroundWidget).title),
        onTap: () {
          var widgetItem = (items[index] as PlaygroundWidget);
          _navigateToWidgetDetail(context, widgetItem.child,
              customTitle: widgetItem.title);
        },
      );
    } else {
      return ListTile(
        leading: Icon(Icons.widgets),
        title: Text(items[index].toString()),
        onTap: () {
          _navigateToWidgetDetail(context, items[index]);
        },
      );
    }
  }

  void _navigateToWidgetDetail(BuildContext context, Widget childWidget,
      {String customTitle}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _PlaygroundDetail(
              child: childWidget,
              appBarColor: widget.appBarColor,
              customTitle: customTitle,
            ),
      ),
    );
  }

  void _navigateToNextPlayground(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaygroundView(
              widgetList: widget.widgetList,
              appBarColor: widget.appBarColor,
              showAtoms: true,
            ),
      ),
    );
  }
}

/*
  Playground screen/widget with the detail of the widget (only one selected)
 */

class _PlaygroundDetail extends StatelessWidget {
  static const Color _defaultAppBarColor = Color(0xFF9CBD3A);

  final Widget child;
  final Color appBarColor;
  final String customTitle;

  _PlaygroundDetail(
      {Key key,
      @required this.child,
      this.appBarColor = _defaultAppBarColor,
      this.customTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(customTitle ?? child.toString()),
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
  static const Color _defaultAppBarColor = Color(0xFF9CBD3A);
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
