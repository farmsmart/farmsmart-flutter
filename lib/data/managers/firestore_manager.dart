import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';

class FireStoreManager {
  static final FireStoreManager _firebaseManager =
      new FireStoreManager._internal();

  static FireStoreManager get() {
    return _firebaseManager;
  }

  FireStoreManager._internal();

  Future<List<CropEntity>> getCrops() async {
    List<CropEntity> cropsEntities;

    // Filters defined by product definition.
    var query = Firestore.instance
        .collection('fl_content')
        .where(FLAME_LINK_SCHEMA, isEqualTo: 'crop')
        .where(FLAME_LINK_ENVIROMENT, isEqualTo: 'production')
        .where(FLAME_LINK_LOCALE, isEqualTo: 'en-US')
        .where(PUBLICATION_STATUS, isEqualTo: 'PUBLISHED');

    await query.getDocuments().then((snapshot) {
      cropsEntities = snapshot.documents.map((cropDocument) {
        return CropEntity.cropFromDocument(cropDocument);
      }).toList();
    });
    return cropsEntities;
  }

  Future<List<CropEntity>> getCropsImagePath(List<CropEntity> cropsList) async {
    List<CropEntity> cropsEntitiesWithImagePath = List();

    for (var crop in cropsList) {
      await Firestore.instance
          .document(crop.imagePathReference)
          .get()
          .then((imageSnapshot) async {
        final imagePath = await getImageDownloadURL(imageSnapshot);
        crop.setImageUrl(imagePath);
        cropsEntitiesWithImagePath.add(crop);
      });
    }
    return cropsEntitiesWithImagePath;
  }

  Future<String> getImageDownloadURL(DocumentSnapshot imageDocument) async {
    final sizePath = imageDocument.data["sizes"].first["path"];
    final imageFileNamePath = imageDocument.data["file"];
    final flamelinkPath =
        IMAGE_BASE_PATH + "/" + sizePath + "/" + imageFileNamePath;
    final storageReference =
        FirebaseStorage.instance.ref().child(flamelinkPath);
    return await storageReference.getDownloadURL();
  }
}
