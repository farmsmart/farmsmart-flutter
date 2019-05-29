import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:farmsmart_flutter/model/crop_detail_property.dart';
import 'package:farmsmart_flutter/model/enums.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/utils/string_utils.dart';
import 'package:farmsmart_flutter/utils/strings.dart';
import 'package:redux/redux.dart';

class MyPlotViewModel {
  LoadingStatus loadingStatus;
  final List<CropEntity> cropsList;
  final CropEntity selectedCrop;
  final StageEntity selectedStage;

  final Function fetchCrops;
  final Function(CropEntity cropData) goToDetail;
  final Function(StageEntity stageData) goToStage;

  MyPlotViewModel({this.loadingStatus,
    this.cropsList,
    this.selectedCrop,
    this.selectedStage,
    this.fetchCrops,
    this.goToDetail,
    this.goToStage});

  static MyPlotViewModel fromStore(Store<AppState> store) {
    return MyPlotViewModel(
        loadingStatus: store.state.myPlotState.loadingStatus,
        cropsList: store.state.myPlotState.cropList,
        selectedCrop: store.state.myPlotState.selectedCrop,
        selectedStage: store.state.myPlotState.selectedStage,
        goToDetail: (CropEntity crop) => store.dispatch(GoToCropDetailAction(crop)),
        goToStage: (StageEntity stage) => store.dispatch(GoToStageAction(stage)),
        fetchCrops: () =>
            store.dispatch(FetchCropListAction())
    );
  }

  List<CropDetailProperty> getCropDetailProperties(CropEntity cropEntity) {
    List<CropDetailProperty> listOfProperties = List();

    if(cropEntity.complexity != null) {
      String complexity = begAdvValues.reverse[cropEntity.complexity];
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailComplexityTitle, Utils.capitalize(complexity)));
    }
    if(Utils.listIsNotNullOrEmpty(cropEntity.soilType)) {
      String soilType = cropEntity.soilType.join(", ");
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailSoilTypeTitle, Utils.capitalize(soilType)));
    }
    if(Utils.listIsNotNullOrEmpty(cropEntity.cropsInRotation)) {
      String soilType = cropEntity.cropsInRotation.join(", ");
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailCropsToBeRotatedTitle, Utils.capitalize(soilType)));
    }
    if(cropEntity.cropType != null) {
      String cropType = cropTypeValues.reverse[cropEntity.cropType];
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailCropTypeTitle, Utils.capitalize(cropType)));
    }
    if(cropEntity.waterRequirement != null) {
      String waterRequirement = loHiValues.reverse[cropEntity.waterRequirement];
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailWaterRequirementTitle, Utils.capitalize(waterRequirement)));
    }
    if(cropEntity.setupCost != null) {
      String setupCost = loHiValues.reverse[cropEntity.setupCost];
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailSetupCostTitle, Utils.capitalize(setupCost)));
    }
    if(cropEntity.profitability != null) {
      String profitability = loHiValues.reverse[cropEntity.profitability];
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailProfitabilityTitle, Utils.capitalize(profitability)));
    }
    if(Utils.listIsNotNullOrEmpty(cropEntity.companionPlants)) {
      String companionPlants = cropEntity.companionPlants.join(", ");
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailCompanionPlantsTitle, Utils.capitalize(companionPlants)));
    }
    if(Utils.listIsNotNullOrEmpty(cropEntity.nonCompanionPlants)) {
      String nonCompanionPlants = cropEntity.nonCompanionPlants.join(", ");
      listOfProperties.add(CropDetailProperty(Strings.myPlotDetailNonCompanionPlantsTitle, Utils.capitalize(nonCompanionPlants)));
    }
    return listOfProperties;
  }
}