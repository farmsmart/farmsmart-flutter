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

  static final ArticleList _articleList = ArticleList(
      key: PageStorageKey('ArticleList'),
      viewModelProvider: ArticleListProvider(
          title: 'Discover',
          repository: articleRepo,
          group: ArticleCollectionGroup.discovery));

  static final PlaygroundView _playgroundView = PlaygroundView(
    key: PageStorageKey('Playground'),
    widgetList: PlaygroundDataSourceImpl().getList(),
  );

  final List<Widget> _pages = [
    _articleList,
    _playgroundView,
  ];

  final List<BottomNavigationBarItem> _barItems = [
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
      title: Text('Debug'),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar Demo',
      home: BottomNavigationBarController(
        pages: _pages,
        barItems: _barItems,
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
      ),
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
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
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
