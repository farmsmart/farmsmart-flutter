import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/data/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleList.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_datasource_impl.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar_controller.dart';

final cms =
FlameLink(store: Firestore.instance, environment: Environment.development);
final articleRepo = ArticlesRepositoryFlameLink(cms);


void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.
  static final double bottomBarIconSize = 25;

  static final Widget _discoverPage = ArticleList(
      viewModelProvider: ArticleListProvider(
          title: 'Discover',
          repository: articleRepo,
          group: ArticleCollectionGroup.discovery));

  static final Widget _myPlotPage = FirstPage();
  static final Widget _profitLossPage = SecondPage();
  static final Widget _communityPage = SecondPage();

  static final Widget _playgroundView = PlaygroundView(
    widgetList: PlaygroundDataSourceImpl().getList(),
  );

  final List<Widget> _pages = [
    _myPlotPage,
    _profitLossPage,
    _discoverPage,
    _communityPage,
    _playgroundView,
  ];

  final List<BottomNavigationBarItem> _barItems = [
    BottomNavigationBarItem(
      activeIcon: Image.asset(Assets.BOTTOM_BAR_MY_PLOT_SELECTED,
          height: bottomBarIconSize),
      icon: Image.asset(Assets.BOTTOM_BAR_MY_PLOT_UNSELECTED,
          height: bottomBarIconSize),
      title: Text('My Plot'),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset(Assets.BOTTOM_BAR_PROFIT_LOSS_SELECTED,
          height: bottomBarIconSize),
      icon: Image.asset(Assets.BOTTOM_BAR_PROFIT_LOSS_UNSELECTED,
          height: bottomBarIconSize),
      title: Text('Profit/Loss'),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset(Assets.BOTTOM_BAR_DISCOVER_SELECTED,
          height: bottomBarIconSize),
      icon: Image.asset(Assets.BOTTOM_BAR_DISCOVER_UNSELECTED,
          height: bottomBarIconSize),
      title: Text('Discover'),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_SELECTED,
          height: bottomBarIconSize),
      icon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_UNSELECTED,
          height: bottomBarIconSize),
      title: Text('Community'),
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_SELECTED,
          height: bottomBarIconSize),
      icon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_UNSELECTED,
          height: bottomBarIconSize),
      title: Text('Debug'),
    )
  ];

  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'GT-America-Standard',
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        primaryColor: const Color(0xFFFFFFFF),
        accentColor: const Color(0xFF757575),
      ),
      home: BottomNavigationBarController(
        pages: _pages,
        barItems: _barItems,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text('Lorem Ipsum'),
          subtitle: Text('$index'),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SecondPage()));
          },
        );
      }),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
            title: Text('Lorem Ipsum'),
            subtitle: Text('$index'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FirstPage()));
            });
      }),
    );
  }
}
