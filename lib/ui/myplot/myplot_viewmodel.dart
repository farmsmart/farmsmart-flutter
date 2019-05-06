import 'package:farmsmart_flutter/data/model/crop_entity.dart';
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

  final Function fetchCrops;
  final Function(CropEntity cropData) goToDetail;

  MyPlotViewModel({this.loadingStatus,
    this.cropsList,
    this.selectedCrop,
    this.fetchCrops,
    this.goToDetail});

  static MyPlotViewModel fromStore(Store<AppState> store) {
    return MyPlotViewModel(
        loadingStatus: store.state.myPlotState.loadingStatus,
        cropsList: store.state.myPlotState.cropList,
        selectedCrop: store.state.myPlotState.selectedCrop,
        goToDetail: (CropEntity crop) => store.dispatch(GoToCropDetailAction(crop)),
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

    return listOfProperties;
  }
}