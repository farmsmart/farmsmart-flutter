import 'package:farmsmart_flutter/redux/home/home_state.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_reducer.dart';

HomeState homeReducer(HomeState state, dynamic action) =>
    new HomeState(
        myPlotState: myPlotReducer(state.myPlotState ,action)
    );