import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/repositories/FlameLink.dart';

class _Fields {
  static const cropName = "cropName";
  static const identifier = "cmsCropId";
}

class _Constants {
  static const lookupCollection = "/fs_crop_score_cms_link";
  static const pathDivider= "/";
}

class CropRecommendationLookup {
  final FlameLink _flameLink;

  CropRecommendationLookup(this._flameLink);

  Future<Map<String,String>> lookupTable() {
      final contentPath = _flameLink.content().path + _Constants.pathDivider;
      return _flameLink.store.collection(_Constants.lookupCollection).getDocuments().then((snapshot){
          return snapshot.documents.asMap().map((_,document){
              return MapEntry(contentPath + _identifier(document),_recomendationName(document));
          });
      });
  }

  String _identifier(DocumentSnapshot snapshot) {
    return castOrNull<String>(snapshot.data[_Fields.identifier]);
  } 

  String _recomendationName(DocumentSnapshot snapshot) {
    return castOrNull<String>(snapshot.data[_Fields.cropName]);
  }
}
