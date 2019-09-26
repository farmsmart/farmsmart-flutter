
import 'package:farmsmart_flutter/model/repositories/crop/implementation/CropRecomendationLookup.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/implementation/transformers/FirebaseToInputFactors.dart';

import '../../FlameLink.dart';
import '../RatingEngineRepositoryInterface.dart';

class _Constants {
  static const cropScoreCollectionName = "fs_crop_scores";
}

class RatingEngineRepositoryFirestore
    implements RatingEngineRepositoryInterface {
  final FlameLink _flamelink;
  CropRecommendationLookup _lookup;
  RatingEngineRepositoryFirestore(this._flamelink) {
    _lookup = CropRecommendationLookup(_flamelink);
  }

  @override
  Future<Map<String, RatingInfo>> getRatingInfo() {
    final transformer = FirebaseToRatingInfoTransformer();
    return _flamelink.store
        .collection(_Constants.cropScoreCollectionName)
        .getDocuments()
        .then((snapshot) {
      return transformer.transform(from: snapshot);
    });
  }

  @override
  Stream<Map<String, RatingInfo>> observeRatingInfo() {
    final transformer = FirebaseToRatingInfoTransformer();
    return _flamelink.store
        .collection(_Constants.cropScoreCollectionName)
        .getDocuments()
        .asStream()
        .transform(transformer.streamTransformer());
  }

  @override
  Future<Map<String,String>> ratingNameLookup() {
    return _lookup.lookupTable();
  }


}
