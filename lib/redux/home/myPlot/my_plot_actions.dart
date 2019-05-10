// We define here every single action that can happen in the my plot pack of tasks.
// This includes adding any kind of error and clearing them also.

import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage.dart';

class FetchCropListAction {
  FetchCropListAction();
}

class UpdateCropListAction {
  List<CropEntity> cropsList;
  UpdateCropListAction(this.cropsList);
}

class GoToCropDetailAction {
  CropEntity crop;
  GoToCropDetailAction(this.crop);
}

class GoToStageAction {
  Stage stage;
  GoToStageAction(this.stage);
}