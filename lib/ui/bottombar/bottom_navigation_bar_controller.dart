import 'package:farmsmart_flutter/ui/bottombar/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavigationBarController extends StatefulWidget {
  final List<TabNavigator> tabs;

  const BottomNavigationBarController({
    Key key,
    this.tabs,
  }) : super(key: key);

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await widget
          .tabs[_selectedIndex].navigatorKey.currentState
          .maybePop(),
      child: Scaffold(
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
        body: Stack(
          children: _buildChildren(widget.tabs),
        ),
      ),
    );
  }

  Widget _bottomNavigationBar(int selectedIndex) {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) => setState(() => _selectedIndex = index),
      currentIndex: selectedIndex,
      items: _buildBarItems(widget.tabs),
    );
  }

  List<BottomNavigationBarItem> _buildBarItems(List<TabNavigator> tabs) {
    return tabs.map((tabNavigator) => tabNavigator.barItem).toList();
  }

  List<Widget> _buildChildren(List<TabNavigator> tabs) {
    List<Widget> children = List();
    tabs.asMap().forEach((index, tabNavigator) =>
        children.add(_buildOffstageNavigators(index, tabNavigator)));
    return children;
  }

  Widget _buildOffstageNavigators(int index, TabNavigator tabNavigator) {
    return Visibility(
      visible: _selectedIndex == index,
      maintainState: true,
      child: tabNavigator,
    );
  }
}
