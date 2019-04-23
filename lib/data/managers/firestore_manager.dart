
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/enums.dart';

class FireStoreManager {
  static final FireStoreManager _firebaseManager = new FireStoreManager._internal();

  static FireStoreManager get() {
    return _firebaseManager;
  }

  FireStoreManager._internal();

  Future<List<CropEntity>> getCrops() async {
    List<CropEntity> cropsEntities;

    // Filters defined by product definition.
    var query = Firestore.instance.collection('fl_content')
        .where('_fl_meta_.schema', isEqualTo: 'crop')
        .where('_fl_meta_.env', isEqualTo: 'production')
        .where('_fl_meta_.locale', isEqualTo: 'en-US')
        .where('status', isEqualTo: 'PUBLISHED');

    await query.getDocuments().then((snapshot)  {
      cropsEntities = snapshot.documents.map((cropDocument) {
        return CropEntity.cropFromDocument(cropDocument);
      }).toList();
    });
    return cropsEntities;
    }

//  Future close() async {
//    return database.close();
//  }
}