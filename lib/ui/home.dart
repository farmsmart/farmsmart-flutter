import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/app_bar.dart';
import 'package:farmsmart_flutter/ui/community/community_child.dart';
import 'package:farmsmart_flutter/ui/discover/discover_child.dart';
import 'package:farmsmart_flutter/ui/home_viewmodel.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_child.dart';
import 'package:farmsmart_flutter/ui/profitloss/profit_loss_child.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
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
    HomeDiscoverChild(),
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

  Widget content(HomeViewmodel viewModel) {
    return Scaffold(
        appBar: CustomAppBar.build(viewModel.currentTab),
        body: _children[viewModel.currentTab],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Color(primaryGreen)
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: viewModel.changeTab,
            currentIndex: viewModel.currentTab,
            items: [
              BottomNavigationBarItem(
                activeIcon: Image.asset("assets/icons/my_plot_selected.png", height: bottomBarIconSize),
                icon: Image.asset("assets/icons/my_plot.png", height: bottomBarIconSize),
                title: Text(Strings.myPlotTab),
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset("assets/icons/profit_loss_selected.png", height: bottomBarIconSize),
                icon: Image.asset("assets/icons/profit_loss.png", height: bottomBarIconSize),
                title: Text(Strings.profitLossTab),
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset("assets/icons/discover_selected.png", height: bottomBarIconSize),
                icon: Image.asset("assets/icons/discover.png", height: bottomBarIconSize),
                title: Text(Strings.discoverTab),
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset("assets/icons/community_selected.png", height: bottomBarIconSize),
                icon: Image.asset("assets/icons/community.png", height: bottomBarIconSize),
                title: Text(Strings.communityTab),
              ),
            ],
          ),
        ));
  }
}
