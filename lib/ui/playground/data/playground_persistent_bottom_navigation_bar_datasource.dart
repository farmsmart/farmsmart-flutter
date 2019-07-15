import 'package:farmsmart_flutter/ui/bottombar/tab_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaygroundPersistentBottomNavigationBar {
  double _bottomBarIconSize = 25;

  List<TabNavigator> getList() {
    return [
      _buildMockTabNavigator(
        1,
        'assets/icons/my_plot_selected.png',
        'assets/icons/my_plot.png',
      ),
      _buildMockTabNavigator(
        2,
        'assets/icons/profit_loss_selected.png',
        'assets/icons/profit_loss.png',
      ),
      _buildMockTabNavigator(
        3,
        'assets/icons/discover_selected.png',
        'assets/icons/discover.png',
      ),
      _buildMockTabNavigator(
        4,
        'assets/icons/community_selected.png',
        'assets/icons/community.png',
      ),
      _buildMockTabNavigatorWithCircleImageWidget(
        5,
      ),
    ];
  }

  TabNavigator _buildMockTabNavigator(
      int pageNumber, String activeIconPath, String iconPath) {
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
        title: SizedBox.shrink(),
      ),
    );
  }

  TabNavigator _buildMockTabNavigatorWithCircleImageWidget(int pageNumber) {
    return TabNavigator(
      child: MockTabPage(
        pageNumber: pageNumber,
      ),
      barItem: BottomNavigationBarItem(
        activeIcon: Container(
          decoration: BoxDecoration(
            color: Color(0xff24d900),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(2.0),
          height: 27,
          child: CircleAvatar(
            child: Image.asset('assets/raw/mock_profile_image.png'),
          ),
        ),
        icon: Container(
          height: 27,
          child: CircleAvatar(
            child: Image.asset('assets/raw/mock_profile_image.png'),
          ),
        ),
        title: SizedBox.shrink(),
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
