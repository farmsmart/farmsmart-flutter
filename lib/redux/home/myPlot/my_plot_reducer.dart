
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_state.dart';
import 'package:redux/redux.dart';

final myPlotReducer = combineReducers<MyPlotState>([
  TypedReducer<MyPlotState, UpdateCropListAction>(_updateCrops),
  TypedReducer<MyPlotState, GoToCropDetailAction>(_goToDetail),
  TypedReducer<MyPlotState, GoToStageAction>(_goToStage),
  TypedReducer<MyPlotState, GoToRelatedArticleDetail>(_goToRelatedArticleDetail),
  // Any other action must be added to this reducer
]);

MyPlotState _updateCrops(MyPlotState state, UpdateCropListAction action) =>
    state.copyWith(loadingStatus: LoadingStatus.SUCCESS, cropList: action.cropsList);

MyPlotState _goToDetail(MyPlotState state, GoToCropDetailAction action) =>
    state.copyWith(selectedCrop: action.crop);

MyPlotState _goToStage(MyPlotState state, GoToStageAction action) =>
    state.copyWith(selectedStage: action.stage);

MyPlotState _goToRelatedArticleDetail(MyPlotState state, GoToRelatedArticleDetail action) =>
    state.copyWith(loadingStatus: LoadingStatus.LOADING, relatedSelectedArticle: action.article);

