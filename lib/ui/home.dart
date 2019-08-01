import 'package:farmsmart_flutter/farmsmart_localizations.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/model/bloc/plot/PlotListProvider.dart';
import 'package:farmsmart_flutter/model/bloc/recommendations/RecommendationEngine.dart';
import 'package:farmsmart_flutter/model/bloc/transactions/ProfitLossListProvider.dart';
import 'package:farmsmart_flutter/model/model/mock/MockRecommendation.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/repository_provider.dart';
import 'package:farmsmart_flutter/ui/article/ArticleList.dart';
import 'package:farmsmart_flutter/ui/bottombar/persistent_bottom_navigation_bar.dart';
import 'package:farmsmart_flutter/ui/bottombar/tab_navigator.dart';
import 'package:farmsmart_flutter/ui/mockData/MockUserProfileViewModel.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_datasource_impl.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:farmsmart_flutter/ui/profile/UserProfile.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossList.dart';
import 'package:flutter/material.dart';

import 'article/ArticleListStyles.dart';
import 'myplot/PlotList.dart';

class _Constants {
  static final double bottomBarIconSize = 25;
  static final Color bottomBarColor = Colors.white;

  static final myPlotSelectedIcon = 'assets/icons/my_plot_selected.png';
  static final myPlotIcon = 'assets/icons/my_plot.png';
  static final profitLossSelectedIcon = 'assets/icons/profit_loss_selected.png';
  static final profitLossIcon = 'assets/icons/profit_loss.png';
  static final discoverSelectedIcon = 'assets/icons/discover_selected.png';
  static final discoverIcon = 'assets/icons/discover.png';
  static final communitySelectedIcon = 'assets/icons/community_selected.png';
  static final communityIcon = 'assets/icons/community.png';
}

final engine = RecommendationEngine(
  inputFactors: harryInput,
  inputScale: 10.0,
  weightMatrix: harryWeights,
);

class Home extends StatelessWidget {
  FarmsmartLocalizations localizations;
  final RepositoryProvider repositoryProvider;

  Home({
    Key key,
    this.repositoryProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    localizations = FarmsmartLocalizations.of(context);

    return PersistentBottomNavigationBar(
      backgroundColor: _Constants.bottomBarColor,
      tabs: tabs(),
    );
  }

  List<TabNavigator> tabs() {
    return [
      _buildTabNavigator(
        _buildMyPlot(),
        _Constants.myPlotSelectedIcon,
        _Constants.myPlotIcon,
      ),
      _buildTabNavigator(
        _buildProfitAndLoss(),
        _Constants.profitLossSelectedIcon,
        _Constants.profitLossIcon,
      ),
      _buildTabNavigator(
        //TODO Check Discover screen after rebase LH's opened PR (white screen)
        _buildDiscover(),
        _Constants.discoverSelectedIcon,
        _Constants.discoverIcon,
      ),
      _buildTabNavigator(
        _buildCommunity(),
        _Constants.communitySelectedIcon,
        _Constants.communityIcon,
      ),
      _buildTabNavigatorWithCircleImageWidget(
        _buildUserProfile(),
      ),
      _buildTabNavigator(
        _buildPlayground(),
        _Constants.communitySelectedIcon,
        _Constants.communityIcon,
      ),
    ];
  }

  _buildMyPlot() {
    return PlotList(
        provider: PlotListProvider(
            title: localizations.myPlotTab,
            engine: engine,
            plotRepository: repositoryProvider.getMyPlotRepository(),
            cropRepository: repositoryProvider.getCropRepository()));
  }

  _buildProfitAndLoss() {
    return ProfitLossPage(
      viewModelProvider: ProfitLossListProvider(
        transactionsRepository: repositoryProvider.getTransactionRepository(),
        cropRepository: repositoryProvider.getCropRepository(),
      ),
    );
  }

  _buildDiscover() {
    return ArticleList(
        style: ArticleListStyles.buildForDiscover(),
        viewModelProvider: ArticleListProvider(
            title: localizations.discoverTab,
            repository: repositoryProvider.getArticleRepository(),
            group: ArticleCollectionGroup.discovery));
  }

  _buildCommunity() {
    return ArticleList(
        style: ArticleListStyles.buildForCommunity(),
        viewModelProvider: ArticleListProvider(
            title: localizations.communityTab,
            repository: repositoryProvider.getArticleRepository(),
            group: ArticleCollectionGroup.chatGroups));
  }

  _buildUserProfile() {
    return UserProfile(
      viewModel: MockUserProfileViewModel.build(),
    );
  }

  _buildPlayground() {
    return PlaygroundView(
      widgetList: PlaygroundDataSourceImpl().getList(),
    );
  }

  TabNavigator _buildTabNavigator(
    Widget page,
    String activeIconPath,
    String iconPath,
  ) {
    return TabNavigator(
      child: page,
      barItem: BottomNavigationBarItem(
        activeIcon: Image.asset(
          activeIconPath,
          height: _Constants.bottomBarIconSize,
        ),
        icon: Image.asset(
          iconPath,
          height: _Constants.bottomBarIconSize,
        ),
        title: SizedBox.shrink(),
      ),
    );
  }

  //TODO Build it properly
  TabNavigator _buildTabNavigatorWithCircleImageWidget(Widget page) {
    return TabNavigator(
      child: page,
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
