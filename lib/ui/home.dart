import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/data/bloc/plot/PlotListProvider.dart';
import 'package:farmsmart_flutter/data/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/data/model/mock/MockRecommendation.dart';
import 'package:farmsmart_flutter/data/repositories/FlameLink.dart';
import 'package:farmsmart_flutter/data/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/ArticlesRepositoryFlamelink.dart';
import 'package:farmsmart_flutter/data/repositories/crop/implementation/MockCropRepository.dart';
import 'package:farmsmart_flutter/data/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:farmsmart_flutter/farmsmart_localizations.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/ui/community/community_child.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleList.dart';
import 'package:farmsmart_flutter/ui/home_viewmodel.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotList.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:farmsmart_flutter/utils/assets.dart';
import 'package:farmsmart_flutter/utils/colors.dart';
import 'package:farmsmart_flutter/utils/dimens.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'profitloss/ProfitLossList.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_datasource_impl.dart';

/// Home "screen" route. Scaffold has all the app subcomponents available inside,
/// like bottom bar or action bar.
///

final cms =
    FlameLink(store: Firestore.instance, environment: Environment.development);
final articleRepo = ArticlesRepositoryFlameLink(cms);
final plotRepo = MockPlotRepository();
final cropRepo = MockCropRepository();

final engine = RecommendationEngine(
  inputFactors: harryInput,
  inputScale: 10.0,
  weightMatrix: harryWeights,
); //TODO: LH get input from User profile.

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
    final discoverTab = Navigator(
        initialRoute: "/discover",
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder = (BuildContext _) => ArticleList(
              viewModelProvider: ArticleListProvider(
                  title: localizations.discoverTab,
                  repository: articleRepo,
                  group: ArticleCollectionGroup.discovery));
          return MaterialPageRoute(builder: builder, settings: settings);
        });

    final plotTab = Navigator(
        initialRoute: "/plot",
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder = (BuildContext _) => PlotList(
                  provider: PlotListProvider(
                title: localizations.myPlotTab,
                plotRepository: plotRepo,
                cropRepository: cropRepo,
                engine: engine,
              ));
          return MaterialPageRoute(builder: builder, settings: settings);
        });

    final List<Widget> _children = [
      plotTab,
      ProfitLossPage(),
      discoverTab,
      HomeCommunityChild(),
      PlaygroundView(
        widgetList: PlaygroundDataSourceImpl().getList(),
      ),
    ];
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
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      var decodedDynamicLink = Uri.decodeComponent(data.link.toString());
      var stringURLtoURI = Uri.parse(decodedDynamicLink);
      if (stringURLtoURI != null) {
        String articleId = stringURLtoURI.queryParameters[DeepLink.ParameterID];
        debugPrint('Fetching id=${articleId}');
        //TODO: LH restore this function
      }
    }
  }
}
