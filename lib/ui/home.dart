import 'package:farmsmart_flutter/farmsmart_localizations.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/model/bloc/home/HomeViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/plot/PlotListProvider.dart';
import 'package:farmsmart_flutter/model/bloc/profile/ProfileDetailProvider.dart';
import 'package:farmsmart_flutter/model/bloc/recommendations/RecommendationListProvider.dart';
import 'package:farmsmart_flutter/model/bloc/transactions/ProfitLossListProvider.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/repository_provider.dart';
import 'package:farmsmart_flutter/ui/article/ArticleList.dart';
import 'package:farmsmart_flutter/ui/bottombar/persistent_bottom_navigation_bar.dart';
import 'package:farmsmart_flutter/ui/bottombar/tab_navigator.dart';
import 'package:farmsmart_flutter/ui/common/ViewModelProviderBuilder.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_datasource_impl.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossList.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'article/ArticleListStyles.dart';
import 'common/ProfileAvatar.dart';
import 'myplot/PlotList.dart';

class _Constants {
  static final double bottomBarIconSize = 25;
  static final double iconSize = 27;
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

class _LocalisedStrings {
  static relatedArticles() => Intl.message('Related articles');

  static relatedGroups() => Intl.message('Related groups');

  static recommendations() => Intl.message('Recommendations');

  static myPlot() => Intl.message('My Plot');

  static discover() => Intl.message('Discover');

  static community() => Intl.message('Community');

  static joinWhatsAppGroup() =>
      Intl.message('Join the WhatsApp group and discuss with fellow farmers.');
}

class _Icons {
  static final whatsApp = 'assets/icons/WhatsApp_Logo_short.png';
}

class Home extends StatelessWidget {
  FarmsmartLocalizations localizations;
  final RepositoryProvider repositoryProvider;
  final HomeViewModelProvider homeViewModelProvider;
  List<TabNavigator> tabList;

  Home({
    Key key,
    this.repositoryProvider,
    this.homeViewModelProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    localizations = FarmsmartLocalizations.of(context);

    return ViewModelProviderBuilder(
      provider: homeViewModelProvider,
      successBuilder: _buildSuccess,
    );
  }

  Widget _buildSuccess(
      {BuildContext context, AsyncSnapshot<HomeViewModel> snapshot}) {
    return PersistentBottomNavigationBar(
      backgroundColor: _Constants.bottomBarColor,
      tabs: tabs(snapshot.data),
    );
  }

  _initTabsList(HomeViewModel viewModel) {
    tabList = [
      _buildTabNavigator(
        _buildMyPlot(viewModel),
        _Constants.myPlotSelectedIcon,
        _Constants.myPlotIcon,
      ),
      _buildTabNavigator(
        _buildProfitAndLoss(viewModel),
        _Constants.profitLossSelectedIcon,
        _Constants.profitLossIcon,
      ),
      _buildTabNavigator(
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
          _buildUserProfile(viewModel), viewModel),
    ];

    if (viewModel.debugMenuVisible) {
      tabList.add(
        _buildDebugTabNavigator(
          _buildPlayground(),
        ),
      );
    }
  }

  List<TabNavigator> tabs(HomeViewModel viewModel) {
    _initTabsList(viewModel);
    return tabList;
  }

  _buildMyPlot(HomeViewModel viewModel) {
    final recommendationsProvider = RecommendationListProvider(
      title: _LocalisedStrings.recommendations(),
      heroThreshold: 0.8,
      plotRepo:
          repositoryProvider.getMyPlotRepository(viewModel.currentProfile),
      cropRepo: repositoryProvider.getCropRepository(),
      profileRepo: viewModel.currentProfile,
      ratingRepo: repositoryProvider.getRatingsRepository(),
    );
    return PlotList(
        provider: PlotListProvider(
            title: _LocalisedStrings.myPlot(),
            plotRepository: repositoryProvider
                .getMyPlotRepository(viewModel.currentProfile),
            recommendationsProvider: recommendationsProvider));
  }

  _buildProfitAndLoss(HomeViewModel viewModel) {
    return ProfitLossPage(
      viewModelProvider: ProfitLossListProvider(
        transactionsRepository: repositoryProvider
            .getTransactionRepository(viewModel.currentProfile),
        plotRepository:
            repositoryProvider.getMyPlotRepository(viewModel.currentProfile),
      ),
    );
  }

  _buildDiscover() {
    return ArticleList(
      style: ArticleListStyles.buildForDiscover(),
      viewModelProvider: ArticleListProvider(
        title: _LocalisedStrings.discover(),
        repository: repositoryProvider.getArticleRepository(),
        group: ArticleCollectionGroup.discovery,
        relatedTitle: _LocalisedStrings.relatedArticles(),
      ),
    );
  }

  _buildCommunity() {
    return ArticleList(
      style: ArticleListStyles.buildForCommunity(),
      viewModelProvider: ArticleListProvider(
        title: _LocalisedStrings.community(),
        repository: repositoryProvider.getArticleRepository(),
        group: ArticleCollectionGroup.chatGroups,
        relatedTitle: _LocalisedStrings.relatedGroups(),
        contentLinkDescription: _LocalisedStrings.joinWhatsAppGroup(),
        contentLinkIcon: _Icons.whatsApp,
      ),
    );
  }

  _buildUserProfile(HomeViewModel viewModel) {
    return Profile(
      provider: ProfileDetailProvider(
        accountRepo: viewModel.currentAccount,
        plotRepo:
            repositoryProvider.getMyPlotRepository(viewModel.currentProfile),
        downloader: repositoryProvider.getDownloader(),
      ),
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

  TabNavigator _buildDebugTabNavigator(
    Widget page,
  ) {
    return TabNavigator(
      child: page,
      barItem: BottomNavigationBarItem(
        activeIcon: Text('Debug', style: TextStyle(color:Color(0xff24d900)),),
        icon: Text('Debug'),
        title: SizedBox.shrink(),
      ),
    );
  }

  Widget _buildProfileIcon(HomeViewModel viewModel) {
    return ProfileAvatar(
      viewModelProvider: ProfileDetailProvider(
          accountRepo: viewModel.currentAccount,
          plotRepo:
              repositoryProvider.getMyPlotRepository(viewModel.currentProfile), downloader: repositoryProvider.getDownloader()),
      width: _Constants.iconSize,
      height: _Constants.iconSize,
    );
  }

  TabNavigator _buildTabNavigatorWithCircleImageWidget(
      Widget page, HomeViewModel viewModel) {
    final profileIcon = _buildProfileIcon(viewModel);
    return TabNavigator(
      child: page,
      barItem: BottomNavigationBarItem(
        activeIcon: Container(
          decoration: BoxDecoration(
            color: Color(0xff24d900),
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(2.0),
          height: _Constants.iconSize,
          width: _Constants.iconSize,
          child: profileIcon,
        ),
        icon: Container(
          height: _Constants.iconSize,
          width: _Constants.iconSize,
          child: profileIcon,
        ),
        title: SizedBox.shrink(),
      ),
    );
  }
}
