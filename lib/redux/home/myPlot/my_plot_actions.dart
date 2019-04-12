// We define here every single action that can happen in the my plot pack of tasks.
// This includes adding any kind of error and clearing them also.

import 'package:farmsmart_flutter/model/crop.dart';

class FetchCropListAction {
  FetchCropListAction();
}

class UpdateCropListAction {
  List<Crop> cropsList;

  UpdateCropListAction(cropsList);
}
