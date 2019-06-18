
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:meta/meta.dart';

// State that controls the home screens / views toggled by the bottom bar.

@immutable
class MyPlotState {
  // Atributes and functions of the my plot state

  final LoadingStatus loadingStatus;
  final List<CropEntity> cropList;
  final CropEntity selectedCrop;
  final StageEntity selectedStage;
  final ArticleEntity relatedSelectedArticle;

  MyPlotState(
      {@required this.loadingStatus,
      @required this.cropList,
      this.selectedCrop,
      this.selectedStage,
      this.relatedSelectedArticle
      });

  // We define an initial state
  factory MyPlotState.initial() {
    return new MyPlotState(
        loadingStatus: LoadingStatus.LOADING, cropList: List());
  }

  // Helper method to create a similar (or equal state) of the home state.
  MyPlotState copyWith(
      {LoadingStatus loadingStatus,
      List<CropEntity> cropList,
      CropEntity selectedCrop,
      StageEntity selectedStage,
      ArticleEntity relatedSelectedArticle }) {
    return new MyPlotState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        cropList: cropList ?? this.cropList,
        selectedCrop: selectedCrop ?? this.selectedCrop,
        selectedStage: selectedStage ?? this.selectedStage,
        relatedSelectedArticle: relatedSelectedArticle ?? this.relatedSelectedArticle);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyPlotState &&
          runtimeType == other.runtimeType &&
          loadingStatus == other.loadingStatus &&
          cropList == other.cropList &&
          selectedCrop == other.selectedCrop &&
          selectedStage == other.selectedStage &&
          relatedSelectedArticle == other.relatedSelectedArticle
  ;

  @override
  int get hashCode =>
      loadingStatus.hashCode ^ cropList.hashCode ^ selectedCrop.hashCode ^ selectedStage.hashCode ^ relatedSelectedArticle.hashCode;
}
