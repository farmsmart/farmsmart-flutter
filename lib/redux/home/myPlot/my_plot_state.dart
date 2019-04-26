import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:meta/meta.dart';

// State that controls the home screens / views toggled by the bottom bar.

@immutable
class MyPlotState {
  // Atributes and functions of the my plot state

  final LoadingStatus loadingStatus;
  final List<CropEntity> cropList;
  final CropEntity selectedCrop;

  MyPlotState(
      {@required this.loadingStatus,
      @required this.cropList,
      this.selectedCrop});

  // We define an initial state
  factory MyPlotState.initial() {
    return new MyPlotState(
        loadingStatus: LoadingStatus.loading, cropList: new List(0));
  }

  // Helper method to create a similar (or equal state) of the home state.
  MyPlotState copyWith(
      {LoadingStatus loadingStatus,
      List<CropEntity> cropList,
      CropEntity selectedCrop}) {
    return new MyPlotState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        cropList: cropList ?? this.cropList,
        selectedCrop: selectedCrop ?? this.selectedCrop);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyPlotState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          cropList == other.cropList &&
          selectedCrop == other.selectedCrop;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^ cropList.hashCode ^ selectedCrop.hashCode;
}
