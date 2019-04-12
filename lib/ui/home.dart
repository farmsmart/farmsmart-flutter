import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/articles/articles_child.dart';
import 'package:farmsmart_flutter/ui/community/community_child.dart';
import 'package:farmsmart_flutter/ui/home_viewmodel.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_child.dart';
import 'package:farmsmart_flutter/ui/profitloss/profit_loss_child.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

/// Home "screen" route. Scaffold has all the app subcomponents available inside,
/// like bottom bar or action bar.

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final List<Widget> _children = [
    HomeMyPlotChild(),
    HomeProfitLossChild(),
    HomeArticlesChild(),
    HomeCommunityChild()

    // TODO add here the 4 screens of the home
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) => SafeArea(
                child: Container(
                  color: Colors.black,
                  child: StoreConnector<AppState, HomeViewmodel>(
                      builder: (_, viewModel) => content(viewModel),
                      converter: (store) => HomeViewmodel.fromStore(store)),
                ),
              )),
    );
  }

  Widget content(HomeViewmodel viewmodel) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.appTitle),
        ),
        body: _children[viewmodel.currentTab],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(primaryColour),
          ),
          child: BottomNavigationBar(
            onTap: viewmodel.changeTab,
            currentIndex: viewmodel.currentTab,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.event_available),
                title: Text(Strings.myPlotTab),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                title: Text(Strings.profitLossTab),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text(Strings.articlesTab),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.accessibility),
                title: Text(Strings.communityTab),
              ),
            ],
          ),
        ));
  }
}
