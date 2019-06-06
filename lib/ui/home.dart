import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/discover/discover_actions.dart';
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
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

/// Home "screen" route. Scaffold has all the app subcomponents available inside,
/// like bottom bar or action bar.

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  HomeViewmodel homeViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _retrieveDynamicLink();
    }
  }

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
            ),
      ),
    );
  }

  Widget content(HomeViewmodel viewModel) {
    homeViewModel = viewModel;
    return Scaffold(
      appBar:
          CustomAppBar.build(viewModel.currentTab, viewModel.goToPrivacyPolicy),
      // We could share a list of pre defined actions for the app bar.
      body: _children[viewModel.currentTab],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(primaryColor: Color(primaryGreen)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: viewModel.changeTab,
          currentIndex: viewModel.currentTab,
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset(Assets.BOTTOM_BAR_MY_PLOT_SELECTED,
                  height: bottomBarIconSize),
              icon: Image.asset(Assets.BOTTOM_BAR_MY_PLOT_UNSELECTED,
                  height: bottomBarIconSize),
              title: Text(Strings.myPlotTab),
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(Assets.BOTTOM_BAR_PROFIT_LOSS_SELECTED,
                  height: bottomBarIconSize),
              icon: Image.asset(Assets.BOTTOM_BAR_PROFIT_LOSS_UNSELECTED,
                  height: bottomBarIconSize),
              title: Text(Strings.profitLossTab),
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(Assets.BOTTOM_BAR_DISCOVER_SELECTED,
                  height: bottomBarIconSize),
              icon: Image.asset(Assets.BOTTOM_BAR_DISCOVER_UNSELECTED,
                  height: bottomBarIconSize),
              title: Text(Strings.discoverTab),
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_SELECTED,
                  height: bottomBarIconSize),
              icon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_UNSELECTED,
                  height: bottomBarIconSize),
              title: Text(Strings.communityTab),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _retrieveDynamicLink() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.retrieveDynamicLink();
    var decodedDynamicLink = Uri.decodeComponent(data.link.toString());
    var stringURLtoURI = Uri.parse(decodedDynamicLink);

    if (stringURLtoURI != null) {
      FireStoreManager fireStoreManager = FireStoreManager.get();
      String articleId = stringURLtoURI.queryParameters[DeepLink.ParameterID];
      ArticleEntity articleEntity =
          await fireStoreManager.getArticleById(articleId);
      ArticleEntity articleWithImage =
          await fireStoreManager.getArticleImagePath(articleEntity);
      homeViewModel.showArticleDetail(articleWithImage);
    }
  }
}
