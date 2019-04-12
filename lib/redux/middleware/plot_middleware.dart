// Middleware in charge of act upon myPlot actions that require network data.

import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_actions.dart';
import 'package:redux/redux.dart';

class MyPlotMiddleWare extends MiddlewareClass<AppState>{
  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FetchCropListAction) {
//      final listOfCrops = await PlotRepository.get().getCropList();
//      store.dispatch(new UpdateCropsListAction(listOfCrops));
    }

    next(action);
  }
}