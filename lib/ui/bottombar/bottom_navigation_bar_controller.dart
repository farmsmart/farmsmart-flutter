import 'package:farmsmart_flutter/ui/bottombar/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavigationBarController extends StatefulWidget {
  final List<Widget> pages;
  final List<BottomNavigationBarItem> barItems;
  final List<GlobalKey<NavigatorState>> navigatorKeys;

  const BottomNavigationBarController({
    Key key,
    this.pages,
    this.barItems,
    this.navigatorKeys,
  })  : assert(pages.length == barItems.length,
            'Pages lenght should match barItems lenght'),
        super(key: key);

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
      onWillPop: () async =>
          !await widget.navigatorKeys[_selectedIndex].currentState.maybePop(),
      child: Scaffold(
        bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
        body: Stack(
          children: _buildChildren(),
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
      items: widget.barItems,
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> children = List();
    widget.pages.asMap().forEach(
        (index, child) => children.add(_buildOffstageNavigators(index)));
    return children;
  }

  Widget _buildOffstageNavigators(int index) {
    return Visibility(
      visible: _selectedIndex == index,
      maintainState: true,
      child: TabNavigator(
        navigatorKey: widget.navigatorKeys[index],
        child: widget.pages[index],
      ),
    );
  }
}
