import 'package:farmsmart_flutter/ui/bottombar/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundPersistentBottomNavigationBar {
  double _bottomBarIconSize = 25;

  List<TabNavigator> getList() {
    return [
      _buildMockTabNavigator(
        1,
        'Tab 1',
        'assets/icons/my_plot_selected.png',
        'assets/icons/my_plot.png',
      ),
      _buildMockTabNavigator(
        2,
        'Tab 2',
        'assets/icons/mprofit_loss_selected.png',
        'assets/icons/profit_loss.png',
      ),
      _buildMockTabNavigator(
        3,
        'Tab 3',
        'assets/icons/discover_selected.png',
        'assets/icons/discover.png',
      ),
      _buildMockTabNavigator(
        4,
        'Tab 4',
        'assets/icons/community_selected.png',
        'assets/icons/community.png',
      ),
      _buildMockTabNavigatorWithCircleImageWidget(
        5,
        'Tab 5',
      ),
    ];
  }

  TabNavigator _buildMockTabNavigator(
      int pageNumber, String title, String activeIconPath, String iconPath) {
    return TabNavigator(
      child: MockTabPage(
        pageNumber: pageNumber,
      ),
      barItem: BottomNavigationBarItem(
        activeIcon: Image.asset(
          activeIconPath,
          height: _bottomBarIconSize,
        ),
        icon: Image.asset(
          iconPath,
          height: _bottomBarIconSize,
        ),
        title: Text(
          title,
        ),
      ),
    );
  }

  TabNavigator _buildMockTabNavigatorWithCircleImageWidget(
      int pageNumber, String title) {
    return TabNavigator(
      child: MockTabPage(
        pageNumber: pageNumber,
      ),
      barItem: BottomNavigationBarItem(
        activeIcon: CircleAvatar(backgroundColor: Colors.green,),
        icon: CircleAvatar(backgroundColor: Colors.green[200],),
        title: Text(
          title,
        ),
      ),
    );
  }
}

class MockTabPage extends StatelessWidget {
  const MockTabPage({Key key, this.pageNumber = 0}) : super(key: key);

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Page number $pageNumber item'),
          subtitle: Text('$index'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MockDetailPage(
                      pageNumber: pageNumber,
                    ),
              ),
            );
          },
        );
      }),
    );
  }
}

class MockDetailPage extends StatelessWidget {
  const MockDetailPage({Key key, this.pageNumber = 0}) : super(key: key);

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Detail page number $pageNumber item'),
          subtitle: Text('$index'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MockDetailPage(
                      pageNumber: pageNumber,
                    ),
              ),
            );
          },
        );
      }),
    );
  }
}
