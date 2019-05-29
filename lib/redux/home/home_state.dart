import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:meta/meta.dart';
import 'screens.dart';

// State that controls the home screens / views toggled by the bottom bar.

@immutable
class HomeState {
  // We will have one value per every sub-state. Every time we
  // create a new sub-state we need to update the required, initial, copywith
  // hashcode and == operators adding it.
  final LoadingStatus loadingStatus;
  final int currentHomeTab;

  HomeState({
    @required this.loadingStatus,
    @required this.currentHomeTab
  });

  // We set all the states initial values
  factory HomeState.initial() {
    return HomeState(
        loadingStatus: LoadingStatus.LOADING, currentHomeTab: MY_PLOT_TAB);
  }

  // Copies the states of the app or replaces for new ones if needed.
  HomeState copyWith({LoadingStatus loadingStatus, int currentHomeTab}) {
    return HomeState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        currentHomeTab: currentHomeTab ?? this.currentHomeTab);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeState &&
          runtimeType == other.runtimeType &&
          // if we add a new one we concat with '&&' chars
          loadingStatus == other.loadingStatus &&
          currentHomeTab == other.currentHomeTab;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^
      currentHomeTab.hashCode; // if we add a new one we concat with '^' char
}
