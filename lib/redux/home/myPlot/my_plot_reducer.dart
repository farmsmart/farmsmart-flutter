
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_state.dart';
import 'package:redux/redux.dart';

final myPlotReducer = combineReducers<MyPlotState>([
  TypedReducer<MyPlotState, UpdateCropListAction>(_updateCrops)
  // Any other action must be added to this reducer
]);

MyPlotState _updateCrops(MyPlotState state, UpdateCropListAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.success, cropList: action.cropsList);


