import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavigationBarController extends StatefulWidget {
  final List<Widget> pages;
  final List<BottomNavigationBarItem> barItems;

  const BottomNavigationBarController({Key key, this.pages, this.barItems})
      : assert(pages.length == barItems.length,
            'Pages lenght should match barItems lenght'),
        super(key: key);

  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<BottomNavigationBarController> {
  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;


  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
        onTap: (int index) => setState(() => _selectedIndex = index),
        currentIndex: selectedIndex,
        items: widget.barItems,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: widget.pages[_selectedIndex],
    );
  }
}