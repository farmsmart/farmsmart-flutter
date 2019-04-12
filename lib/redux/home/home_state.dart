import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/redux/home/myPlot/my_plot_state.dart';
import 'package:meta/meta.dart';

// State that controls the home screens / views toggled by the bottom bar.

@immutable
class HomeState {
  // We will have one value per every sub-state. Every time we
  // create a new sub-state we need to update the required, initial, copywith
  // hashcode and == operators adding it.
  LoadingStatus loadingStatus;
  final MyPlotState myPlotState;

  HomeState({
    @required LoadingStatus loadingStatus,
    @required this.myPlotState,
  });

  // We set all the states initial values
  factory HomeState.initial() {
    return HomeState(
      loadingStatus: LoadingStatus.loading,
      myPlotState: MyPlotState.initial(),
    );
  }

  // Copies the states of the app or replaces for new ones if needed.
  HomeState copyWith({HomeState homeState}) {
    return HomeState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        myPlotState: homeState ?? this.myPlotState);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          // if we add a new one we concat with '&&' chars
          loadingStatus == other.loadingStatus &&
          myPlotState == other.myPlotState;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^
      myPlotState.hashCode; // if we add a new one we concat with '^' char

}
