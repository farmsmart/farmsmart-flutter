import 'package:farmsmart_flutter/chat/ChatPage.dart';
import 'package:farmsmart_flutter/model/bloc/SequencedViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/StaticViewModelProvider.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/model/bloc/plot/PlotDetailProvider.dart';
import 'package:farmsmart_flutter/model/bloc/recommendations/RecommendationListProvider.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockPlot.dart';
import 'package:farmsmart_flutter/model/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/model/repositories/crop/implementation/MockCropRepository.dart';
import 'package:farmsmart_flutter/model/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:farmsmart_flutter/model/repositories/profile/implementation/MockProfileRepository.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/implementation/MockRatingEngineRepository.dart';
import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:farmsmart_flutter/ui/article/ArticleList.dart';
import 'package:farmsmart_flutter/ui/bottombar/persistent_bottom_navigation_bar.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/Alert.dart';
import 'package:farmsmart_flutter/ui/common/InputAlert.dart';
import 'package:farmsmart_flutter/ui/common/carousel_view.dart';
import 'package:farmsmart_flutter/ui/community/LinkBox.dart';
import 'package:farmsmart_flutter/ui/community/LinkBoxStyles.dart';
import 'package:farmsmart_flutter/ui/community/MockLinkBox.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockAlertWidgetViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockFarmDetailsViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockInputAlertWidgetViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockLandingPageViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRecordTransactionViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockSwitchProfile.dart';
import 'package:farmsmart_flutter/ui/mockData/MockUserProfileViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotDetail.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_stagecard_datasource.dart';
import 'package:farmsmart_flutter/ui/playground/playground_present_button.dart';
import 'package:farmsmart_flutter/ui/playground/playground_take_image_tester.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetails.dart';
import 'package:farmsmart_flutter/ui/profile/SwitchProfileList.dart';
import 'package:farmsmart_flutter/ui/profile/Profile.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockTransactionRepository.dart';
import 'package:farmsmart_flutter/ui/recommendations/RecommentationsList.dart';
import 'package:farmsmart_flutter/ui/recommendations/viewmodel/MockRecommendationsListViewModel.dart';
import 'package:farmsmart_flutter/ui/recommendations/viewmodel/RecommendationsListViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../playground_view.dart';
import 'playground_persistent_bottom_navigation_bar_datasource.dart';

class PlayGroundTasksDataSource implements PlaygroundDataSource {
  final _mockPlot = MockPlotRepository(MockProfileRepository());
  final _mockCrop = MockCropRepository();
  final _mockProfile = MockProfileRepository();
  final _mockRatingRepo = MockRatingEngineRepository();

  @override
  List<PlaygroundWidget> getList() {
    return [
      //Add Your tasks here
      PlaygroundWidget(
          title: 'TASK FARM-62 View-Prof-Loss-Statement',
          child: PlaygroundView(
            widgetList: [
              PlaygroundWidget(
                title: 'TASK FARM-62 Profit-Loss Header',
                child: ProfitLossHeader(
                    viewModel: MockProfitLossHeaderViewModel.build(),
                    style: ProfitLossHeaderStyle.defaultStyle()),
              ),
              PlaygroundWidget(
                title: 'TASK FARM-62 Profit-Loss Item Negative',
                child: ProfitLossListItem(
                    viewModel: MockProfitLossListItemViewModel.buildNegative(),
                    style: ProfitLossItemStyle.defaultStyle()),
              ),
              PlaygroundWidget(
                title: 'TASK FARM-62 Profit-Loss Item Positive',
                child: ProfitLossListItem(
                    viewModel: MockProfitLossListItemViewModel.buildPositive(),
                    style: ProfitLossItemStyle.defaultStyle()),
              ),
            ],
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet',
          child: PlaygroundView(
            widgetList: [
              PlaygroundWidget(
                title: 'FARM-355 Generic Action Sheet - Simple',
                child: Container(
                  height: 350,
                  child: ActionSheet(
                      viewModel: MockActionSheetViewModel.buildStandard(),
                      style: ActionSheetStyle.defaultStyle()),
                ),
              ),
              PlaygroundWidget(
                title: 'FARM-355 Generic Action Sheet - Larger',
                child: Container(
                  height: 420,
                  child: ActionSheet(
                      viewModel: MockActionSheetViewModel.buildStandardBigger(),
                      style: ActionSheetStyle.defaultStyle()),
                ),
              ),
              PlaygroundWidget(
                  title: 'FARM-355 Generic Action Sheet - With icons',
                  child: Container(
                    height: 350,
                    child: ActionSheet(
                        viewModel: MockActionSheetViewModel.buildWithIcon(),
                        style: ActionSheetStyle.defaultStyle()),
                  )),
              PlaygroundWidget(
                  title: 'FARM-355 Generic Action Sheet - With checkBox',
                  child: Container(
                      height: 350,
                      child: ActionSheet(
                          viewModel:
                              MockActionSheetViewModel.buildWithCheckBox(),
                          style: ActionSheetStyle.defaultStyle()))),
            ],
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet - Type 4',
          child: Container(
              height: 350,
              child: ActionSheet(
                  viewModel: MockActionSheetViewModel.buildWithCheckBox(),
                  style: ActionSheetStyle.defaultStyle()))),

      PlaygroundWidget(
        title: 'TASK FARM-278 State carousel view',
        child: Container(
          height: 162,
          child: CarouselView(
            pageController: PageController(viewportFraction: 0.85, initialPage: 0),
            children: PlaygroundStageCardDataSource().getList(),
          ),
        ),
      ),
      PlaygroundWidget(
          title: "FARM-280 Update Discover",
          child: ArticleList(
              viewModelProvider: ArticleListProvider(
                  title: "Test",
                  repository: MockArticlesRepository(articleCount: 2000)))),
      PlaygroundWidget(
        title: "FARM-48 Landing Page",
        child: PlaygroundPresentButton(
          child: LandingPage(
            viewModel: MockLandingPageViewModel.build(),
          ),
        ),
      ),
      PlaygroundWidget(
        title: "SPIKE Chat page",
        child: PlaygroundPresentButton(
          child: ChatPage(),
        ),
      ),
      PlaygroundWidget(
        title: 'FARM-59 Record a Cost/Sale',
        child: PlaygroundView(widgetList: [
          PlaygroundWidget(
            title: 'Record a Sale',
            child: RecordTransaction(
              viewModel: MockRecordTransactionViewModel.buildSaleTransaction(),
            ),
          ),
          PlaygroundWidget(
            title: 'Record a Cost',
            child: RecordTransaction(
              viewModel: MockRecordTransactionViewModel.buildCostTransaction(),
            ),
          ),
          PlaygroundWidget(
            title: 'View a Sale',
            child: RecordTransaction(
              viewModel: MockRecordTransactionViewModel.buildViewSale(),
            ),
          ),
          PlaygroundWidget(
            title: 'View a Cost',
            child: RecordTransaction(
              viewModel: MockRecordTransactionViewModel.buildViewCost(),
            ),
          ),
        ]),
      ),
      PlaygroundWidget(
        title: "FARM-280 Update Discover",
        child: ArticleList(
          viewModelProvider: ArticleListProvider(
              title: "Test",
              repository: MockArticlesRepository(articleCount: 2000)),
        ),
      ),
      PlaygroundWidget(
        title: "FARM-342 Persistent Bottom navigation bar",
        child: PersistentBottomNavigationBar(
          backgroundColor: Colors.white,
          tabs: PlaygroundPersistentBottomNavigationBar().getList(),
        ),
      ),
      PlaygroundWidget(
        title: "FARM-67 Switch profiles",
        child: PlaygroundPresentButton(
          child: SwitchProfileList(
            provider: StaticViewModelProvider(MockSwitchProfile.build()),
          )
        ),
      ),
      PlaygroundWidget(
          title: 'FARM-63 View Profile',
          child: PlaygroundView(widgetList: [
            PlaygroundWidget(
              title: 'Simple view',
              child: Profile(provider: StaticViewModelProvider<ProfileViewModel>(MockProfileViewModel.build())),
            ),
            PlaygroundWidget(
              title: 'Larger titles view',
              child: Profile(
                  provider: StaticViewModelProvider<ProfileViewModel>(MockProfileViewModel.buildLarger()),
            )),
          ])),
      PlaygroundWidget(
        title: "FARM-432 General Alert Widget",
        child: PlaygroundView(
          widgetList: [
            PlaygroundWidget(
              title: "Normal",
              child: PlaygroundPresentButton(
                child: Alert(
                  viewModel: MockAlertWidgetViewModel.build(),
                ),
                listener: (alert, context) => Alert.present(alert, context),
              ),
            ),
            PlaygroundWidget(
              title: "Have Destructive",
              child: PlaygroundPresentButton(
                child: Alert(
                  viewModel: MockAlertWidgetViewModel.buildDestructive(),
                ),
                listener: (alert, context) => Alert.present(alert, context),
              ),
            ),
            PlaygroundWidget(
              title: "Input Alert",
              child: PlaygroundPresentButton(
                child: InputAlert(
                  viewModel: MockInputAlertViewModel.build(),
                ),
                listener: (alert, context) => Alert.present(alert, context),
              ),
            ),

          ],
        ),
      ),
      PlaygroundWidget(
        title: 'TASK FARM-443 Farm Details',
        child: PlaygroundView(
          widgetList: [
            PlaygroundWidget(
              title: "FARM-443 Show farm details",
              child: PlaygroundPresentButton(
                child: FarmDetails(
                  viewModel: MockFarmDetailsViewModel.build(),
                )
              ),
            ),
          ],
        ),
      ),
      PlaygroundWidget(
        title: 'TASK FARM-97 Update Recomentations',
        child: PlaygroundView(
          widgetList: [
            PlaygroundWidget(
              title: "TASK FARM-97 View List states",
              child: RecommendationsList(
                provider:
                    SequencedViewModelProvider<RecommendationsListViewModel>(
                  [
                    MockRecommendationsListViewModel().build(),
                    MockRecommendationsListViewModel().build(),
                    MockRecommendationsListViewModel().build(),
                    MockRecommendationsListViewModel().build(),
                  ],
                ),
              ),
            ),
            PlaygroundWidget(
              title: "TASK FARM-97 Mock repo",
              child: RecommendationsList(
                provider: RecommendationListProvider(
                  title: "Mock Repo",
                  cropRepo: _mockCrop,
                  plotRepo: _mockPlot,
                  profileRepo: _mockProfile,
                  ratingRepo: _mockRatingRepo
                ),
              ),
            ),
          ],
        ),
      ),
      PlaygroundWidget(
        title: 'TASK-318 Take picture camera',
        child: PlaygroundTakeImageTester(
          imageSource: ImageSource.camera,
        ),
      ),
      PlaygroundWidget(
        title: 'TASK-318 Take picture gallery',
        child: PlaygroundTakeImageTester(
          imageSource: ImageSource.gallery,
        ),
      ),
      PlaygroundWidget(
        title: "TASK FARM-97 Mock repo",
        child: RecommendationsList(
          provider: RecommendationListProvider(
            title: "Mock Repo",
            cropRepo: _mockCrop,
            plotRepo: _mockPlot,
            profileRepo: _mockProfile,
            ratingRepo: _mockRatingRepo,
          ),
        ),
      ),
      PlaygroundWidget(
        title: "FARM-365 Plot Detail",
        child: PlotDetail(
          provider: PlotDetailProvider(
            MockPlotEntity().build(),
            MockPlotRepository(MockProfileRepository()),
          ),
        ),
      ),
      PlaygroundWidget(
        title: 'TASK FARM-445-UI-Join-Chat-Widget',
        child: PlaygroundView(
          widgetList: [
            PlaygroundWidget(
              title: "With WhatsApp Image",
              child: LinkBox(
                viewModel: MockLinkBoxViewModel.buildWithImage(),
                style: LinkBoxStyles.buildWhatsAppStyle(),
              ),
            ),
            PlaygroundWidget(
              title: "With Browser Icon",
              child: LinkBox(
                viewModel: MockLinkBoxViewModel.buildWithIcon(),
                style: LinkBoxStyles.buildBrowserStyle(),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
