import 'package:farmsmart_flutter/ui/bottombar/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PersistentBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final List<TabNavigator> tabs;

  const PersistentBottomNavigationBar({
    Key key,
    this.backgroundColor = Colors.white,
    this.tabs,
  }) : super(key: key);

  @override
  _PersistentBottomNavigationBarState createState() =>
      _PersistentBottomNavigationBarState();
}

class _PersistentBottomNavigationBarState
    extends State<PersistentBottomNavigationBar> {
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
      backgroundColor: widget.backgroundColor,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        if(_selectedIndex == index){
          widget.tabs[_selectedIndex].navigatorKey.currentState.popUntil((route) => route.isFirst);
        }
        setState(() => _selectedIndex = index);
      },
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
        children.add(_buildVisibilityNavigators(index, tabNavigator)));
    return children;
  }

  Widget _buildVisibilityNavigators(int index, TabNavigator tabNavigator) {
    return Visibility(
      visible: _selectedIndex == index,
      maintainState: true,
      child: tabNavigator,
    );
  }
}
