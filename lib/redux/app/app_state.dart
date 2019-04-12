import 'package:farmsmart_flutter/redux/home/home_state.dart';
import 'package:meta/meta.dart';

// Class that controls the global state of the app
// For architecture purposes we sub-divide it in smaller appstates.
@immutable
class AppState{

  // We will have one value per every sub-state. Every time we
  // create a new sub-state we need to update the required, initial, copywith
  // hashcode and == operators adding it.
  final HomeState homeState;

  AppState({
    @required this.homeState,
  });


  // We set all the states initial values
  factory AppState.initial(){
    return AppState(
        homeState: HomeState.initial(),
    );
  }

  // Copies the states of the app or replaces for new ones if needed.
  AppState copyWith({
    HomeState homeState
  }){
    return AppState(
        homeState: homeState ?? this.homeState
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              // if we add a new one we concat with '&&' chars
              homeState == other.homeState;

  @override
  int get hashCode =>
      homeState.hashCode; // if we add a new one we concat with '^' char

}