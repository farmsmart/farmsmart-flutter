import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:farmsmart_flutter/model/enums.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';

import 'package:farmsmart_flutter/flavors/flavor.dart';

class FireStoreManager {
  static final FireStoreManager _firebaseManager =
      new FireStoreManager._internal();

  static FireStoreManager get() {
    return _firebaseManager;
  }

  FireStoreManager._internal();

  Future<List<CropEntity>> getCrops() async {
    // Filters defined by product definition. - CROPS
    var query = Firestore.instance
        .collection(FLAME_LINK_CONTENT)
        .where(FLAME_LINK_SCHEMA, isEqualTo: Schema.CROP)
        .where(FLAME_LINK_ENVIROMENT, isEqualTo: AppSettings.get().environment)
        .where(FLAME_LINK_LOCALE, isEqualTo: Locale.EN_US)
        .where(PUBLICATION_STATUS, isEqualTo: DataStatus.PUBLISHED);

    return query.getDocuments().then((snapshot) => snapshot.documents
        .map((cropDocument) => CropEntity.cropFromDocument(cropDocument))
        .toList());
  }


  Future<dynamic> getStagesForCrop(CropEntity cropEntity) {
    List<Future<StageEntity>> stages = (cropEntity.stagesPathReference ?? [])
        .map((String path) => Firestore.instance.document(path).get().then(
            (stagesSnapshot) => StageEntity.stageFromDocument(stagesSnapshot)))
        .toList();

    return Future.wait(stages).then((stages) {
      List<StageEntity> stageEntities = stages
          .where((stage) => stage != null && stage.status == Status.PUBLISHED)
          .toList();
      cropEntity.stages = stageEntities;
      return cropEntity;
    });
  }

  Future<dynamic> getCropsImagePath(List<CropEntity> cropsList) async {
    List<Future<dynamic>> imageFetchFutures = List();

    imageFetchFutures = cropsList
        .map((CropEntity crop) => Firestore.instance
                .document(crop.imagePathReference)
                .get()
                .then((DocumentSnapshot snapshot) {
              Future<String> path = getImageDownloadURL(snapshot);
              crop.setImageUrl(path);
              return crop;
            }))
        .toList();

    return Future.wait(imageFetchFutures);
  }

  Future<String> getImageDownloadURL(DocumentSnapshot imageDocument) {
    final sizePath = imageDocument.data[imageSizes].first[imagePath];
    final imageFileNamePath = imageDocument.data[imageFile];
    final flamelinkPath =
        IMAGE_BASE_PATH + '/' + sizePath + '/' + imageFileNamePath;
    final storageReference =
        FirebaseStorage.instance.ref().child(flamelinkPath);
    return storageReference.getDownloadURL().then((value) => value.toString());
  }

  Future<ArticlesDirectoryEntity> getArticlesDirectory() async {
    // Filters defined by product definition. - ARTICLES DIRECTORY
    var query = Firestore.instance
        .collection(FLAME_LINK_CONTENT)
        .where(FLAME_LINK_SCHEMA, isEqualTo: Schema.ARTICLE_DIRECTORY)
        .where(FLAME_LINK_SCHEMA_TYPE, isEqualTo: SchemaType.SINGLE)
        .where(FLAME_LINK_ENVIROMENT, isEqualTo: AppSettings.get().environment)
        .where(FLAME_LINK_LOCALE, isEqualTo: Locale.EN_US);

    // Returns a single directory entity or empty if the record does not exist.
    return query.getDocuments().then((snapshot) => snapshot.documents
        .map((doc) => ArticlesDirectoryEntity.featuredArticlesFromDocument(doc))
        .singleWhere((_) => true,
            orElse: () => ArticlesDirectoryEntity.empty()));
  }

  Future<List<ArticleEntity>> fetchArticles(List<String> articlesDirectory) {
    return fetchArticlesByLimit(
        articlesDirectory, (articlesDirectory ?? []).length);
  }


  Future<List<ArticleEntity>> fetchArticlesByLimit(
      List<String> articlePaths, int limit) {
    List<Future<ArticleEntity>> articleFutures = List();
    articleFutures = (articlePaths ?? [])
        .map((String articlePathReference) => Firestore.instance
            .document(articlePathReference)
            .get()
            .then((articleSnapshot) =>
                ArticleEntity.articleFromDocument(articleSnapshot)))
        .toList();

    return Future.wait(articleFutures).then((articles) => articles
        .where((each) => each.status == Status.PUBLISHED)
        .take(limit)
        .toList());
  }

  Future<ArticleEntity> getArticleById(String articlePathReference) {
    if (articlePathReference != null) {
      return Firestore.instance
          .document(FLAME_LINK_CONTENT + "/" + articlePathReference)
          .get()
          .then((fetchedArticlesSnapshot) =>
      (fetchedArticlesSnapshot.data != null)
          ? ArticleEntity.articleFromDocument(fetchedArticlesSnapshot)
          : null);
    } else {
      return Future.value(null);
    }
  }

}