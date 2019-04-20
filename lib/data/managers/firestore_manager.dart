
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
    await Firestore.instance.collection('fl_content').getDocuments().then((snapshot)  {
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