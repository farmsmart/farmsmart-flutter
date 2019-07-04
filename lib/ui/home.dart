import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/app_bar.dart';
import 'package:farmsmart_flutter/farmsmart_localizations.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/PlaygroundWidgetTryOut.dart';
import 'package:farmsmart_flutter/ui/community/community_child.dart';
import 'package:farmsmart_flutter/ui/discover/discover_page.dart';
import 'package:farmsmart_flutter/ui/home_viewmodel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRoundedButtonViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockDogTagViewModel.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:farmsmart_flutter/ui/common/Dogtag.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotList.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockTransactionRepository.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'profitloss/ProfitLossList.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:farmsmart_flutter/flavors/flavor.dart';

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
      _retrieveDynamicLink(homeViewModel);
    }
  }

  final List<Widget> _children = [
    PlotList(),
    ProfitLossPage(),
    ArticleList(),
    HomeCommunityChild(),
    PlaygroundView(widgetList: [
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildLarge(), style: RoundedButtonStyle.largeRoundedButtonStyle()),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildCompact(), style: RoundedButtonStyle.compactRoundedButton()),
      RoundedButton(viewModel: MockRoundedButtonViewModel.buildCompact(), style: RoundedButtonStyle.compactBigRoundedButton()),
      ProfitLossHeader(viewModel: MockProfitLossHeaderViewModel.build(), style: ProfitLossHeaderStyle.defaultStyle()),
      ProfitLossListItem(viewModel: MockProfitLossListItemViewModel.buildPositive(), style: ProfitLossItemStyle.defaultStyle()),
      ProfitLossListItem(viewModel: MockProfitLossListItemViewModel.buildNegative(), style: ProfitLossItemStyle.defaultStyle()),
      DogTag(viewModel: MockDogTagViewModel.buildWithText(), style: DogTagStyle.defaultStyle()),
      DogTag(viewModel: MockDogTagViewModel.buildWithPositiveNumber(), style: DogTagStyle.positiveStyle()),
      DogTag(viewModel: MockDogTagViewModel.buildWithNegativeNumber(), style: DogTagStyle.negativeStyle())
    ], appBarColor: Color(0xFF9CBD3A)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          child: Container(
            color: Color(black),
            child: StoreConnector<AppState, HomeViewmodel>(
                builder: (_, viewModel) => content(context, viewModel),
                converter: (store) => HomeViewmodel.fromStore(store)),
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context, HomeViewmodel viewModel) {
    homeViewModel = viewModel;
    FarmsmartLocalizations localizations = FarmsmartLocalizations.of(context);
    return Scaffold(
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
              title: Text(localizations.myPlotTab),
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(Assets.BOTTOM_BAR_PROFIT_LOSS_SELECTED,
                  height: bottomBarIconSize),
              icon: Image.asset(Assets.BOTTOM_BAR_PROFIT_LOSS_UNSELECTED,
                  height: bottomBarIconSize),
              title: Text(localizations.profitLossTab),
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(Assets.BOTTOM_BAR_DISCOVER_SELECTED,
                  height: bottomBarIconSize),
              icon: Image.asset(Assets.BOTTOM_BAR_DISCOVER_UNSELECTED,
                  height: bottomBarIconSize),
              title: Text(localizations.discoverTab),
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_SELECTED,
                  height: bottomBarIconSize),
              icon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_UNSELECTED,
                  height: bottomBarIconSize),
              title: Text(localizations.communityTab),
            ),
            BottomNavigationBarItem(
              activeIcon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_SELECTED,
                  height: bottomBarIconSize),
              icon: Image.asset(Assets.BOTTOM_BAR_COMMUNITY_UNSELECTED,
                  height: bottomBarIconSize),
              title: Text(localizations.playgroundTab),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _retrieveDynamicLink(HomeViewmodel viewModel) async {
    final PendingDynamicLinkData data =
    await FirebaseDynamicLinks.instance.retrieveDynamicLink();
    if (data != null) {
      var decodedDynamicLink = Uri.decodeComponent(data.link.toString());
      var stringURLtoURI = Uri.parse(decodedDynamicLink);
      if (stringURLtoURI != null) {
        String articleId = stringURLtoURI.queryParameters[DeepLink.ParameterID];
        debugPrint('Fetching id=${articleId}');
        homeViewModel.getSingleArticle(articleId);
      }
    }
  }
}