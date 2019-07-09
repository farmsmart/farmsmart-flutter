import 'package:farmsmart_flutter/redux/app/app_state.dart';
import 'package:farmsmart_flutter/redux/home/home_reducer.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_reducer.dart';

AppState appReducer(AppState state, dynamic action) =>
    AppState(
        homeState: homeReducer(state.homeState ,action),
        myPlotState: myPlotReducer(state.myPlotState, action)
    );