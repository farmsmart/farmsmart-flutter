import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
        .collection(FLAME_LINK_CONTENT)
        .where(FLAME_LINK_SCHEMA, isEqualTo: Schema.CROP)
        .where(FLAME_LINK_ENVIROMENT, isEqualTo: FirestoreEnvironment.PRODUCTION)
        .where(FLAME_LINK_LOCALE, isEqualTo: Locale.EN_US)
        .where(PUBLICATION_STATUS, isEqualTo: DataStatus.PUBLISHED);

    await query.getDocuments().then((snapshot) {
      cropsEntities = snapshot.documents.map((cropDocument) {
        return CropEntity.cropFromDocument(cropDocument);
      }).toList();
    });
    return cropsEntities;
  }

  Future<List<CropEntity>> getStages(List<CropEntity> cropsList) async {
    List<CropEntity> cropsWithStages = List();

    for (var crop in cropsList) {
      await Firestore.instance
          .document(crop.stagesPathReference.first)
          .get()
          .then((stagesSnapshot) async {
        var stages = "";
        if(stagesSnapshot.data != null) {

//          stages = await getStagesData()
        }
        crop.setStages(stages);
        cropsWithStages.add(crop);
      });
    }
    return cropsWithStages;
  }

  Future<List<CropEntity>> getCropsImagePath(List<CropEntity> cropsList) async {
    List<CropEntity> cropsEntitiesWithImagePath = List();

    for (var crop in cropsList) {
      await Firestore.instance
          .document(crop.imagePathReference)
          .get()
          .then((imageSnapshot) async {
        var imagePath = "";
            if(imageSnapshot.data != null) {
              imagePath = await getImageDownloadURL(imageSnapshot);
            }
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
        IMAGE_BASE_PATH + '/' + sizePath + '/' + imageFileNamePath;
    final storageReference =
        FirebaseStorage.instance.ref().child(flamelinkPath);
    return await storageReference.getDownloadURL();
  }
}
