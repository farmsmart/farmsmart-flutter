
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/implementation/transformers/FirebaseToInputFactors.dart';

import '../RatingEngineRepositoryInterface.dart';


class _Constants {
  static const cropScoreCollectionName = "fs_crop_scores";

}

class RatingEngineRepositoryFirestore implements RatingEngineRepositoryInterface {

  final Firestore _store;

  RatingEngineRepositoryFirestore(this._store);

  @override
  Future<Map<String, RatingInfo>> getRatingInfo() {
    final transformer = FirebaseToRatingInfoTransformer();
    return _store.collection(_Constants.cropScoreCollectionName).getDocuments().then((snapshot){
          return transformer.transform(from: snapshot.documents);
    });
  }

  @override
  Future<Map<String, RatingInfo>> observeRatingInfo() {
    // TODO: implement observeRatingInfo
    return null;
  }

 
}