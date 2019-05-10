import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/app_bar.dart';
import 'package:farmsmart_flutter/ui/community/community_child.dart';
import 'package:farmsmart_flutter/ui/discover/discover_page.dart';
import 'package:farmsmart_flutter/ui/home_viewmodel.dart';
import 'package:farmsmart_flutter/ui/myplot/my_plot_page.dart';
import 'package:farmsmart_flutter/ui/profitloss/profit_loss_child.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
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
    HomeMyPlotPage(),
    HomeProfitLossChild(),
    HomeDiscoverPage(),
    HomeCommunityChild()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) => SafeArea(
                child: Container(
                  color: Color(black),
                  child: StoreConnector<AppState, HomeViewmodel>(
                      builder: (_, viewModel) => content(viewModel),
                      converter: (store) => HomeViewmodel.fromStore(store)),
                ),
              )),
    );
  }

  Widget content(HomeViewmodel viewModel) {
    return Scaffold(
        appBar: CustomAppBar.build(viewModel.currentTab, viewModel.goToPrivacyPolicy), // We could share a list of pre defined actions for the app bar.
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
                activeIcon: Image.asset(Assets.BOTTOM_BAR_MY_PLOT_SELECTED, height: bottomBarIconSize),
                icon: Image.asset(Assets.BOTTOM_BAR_MY_PLOT_UNSELECTED, height: bottomBarIconSize),
                title: Text(Strings.myPlotTab),
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(Assets.BOTTOM_BAR_PROFIT_LOSS_SELECTED, height: bottomBarIconSize),
                icon: Image.asset(Assets.BOTTOM_BAR_PROFIT_LOSS_UNSELECTED, height: bottomBarIconSize),
                title: Text(Strings.profitLossTab),
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(Assets.BOTTOM_BAR_DISCOVER_SELECTED, height: bottomBarIconSize),
                icon: Image.asset(Assets.BOTTOM_BAR_DISCOVER_UNSELECTED, height: bottomBarIconSize),
                title: Text(Strings.discoverTab),
              ),
              BottomNavigationBarItem(
                activeIcon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_SELECTED, height: bottomBarIconSize),
                icon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_UNSELECTED, height: bottomBarIconSize),
                title: Text(Strings.communityTab),
              ),
            ],
          ),
        ));
  }
}
