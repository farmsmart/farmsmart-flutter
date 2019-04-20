import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:redux/redux.dart';

class MyPlotViewModel {
  LoadingStatus loadingStatus;
  final List<CropEntity> cropsList;

  final Function fetchCrops;
  final Function(CropEntity cropData) goToDetail;

  MyPlotViewModel({this.loadingStatus,
    this.cropsList,
    this.fetchCrops,
    this.goToDetail});

  static MyPlotViewModel fromStore(Store<AppState> store) {
    return MyPlotViewModel(
        loadingStatus: store.state.myPlotState.loadingStatus,
        cropsList: store.state.myPlotState.cropList,
        fetchCrops: () =>
            store.dispatch(new FetchCropListAction())
    );
  }
}