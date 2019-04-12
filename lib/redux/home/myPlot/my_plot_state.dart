import 'package:farmsmart_flutter/model/crop.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:meta/meta.dart';

// State that controls the home screens / views toggled by the bottom bar.

@immutable
class MyPlotState {
  // Atributes and functions of the my plot state

  final LoadingStatus loadingStatus;
  final List<Crop> cropList;

  MyPlotState({@required this.loadingStatus, @required this.cropList});

  // We define an initial state
  factory MyPlotState.initial() {
    return new MyPlotState(
        loadingStatus: LoadingStatus.loading,
        cropList: new List(0)); // TODO check how to unify this key
  }

  // Helper method to create a similar (or equal state) of the home state.
  MyPlotState copyWith({LoadingStatus loadingStatus, List<Crop> cropList}) {
    return new MyPlotState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        cropList: cropList ?? this.cropList);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyPlotState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          cropList == other.cropList;

  @override
  int get hashCode => loadingStatus.hashCode ^ cropList.hashCode;
}
