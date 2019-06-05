import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
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
    List<CropEntity> cropsEntities;

    // Filters defined by product definition. - CROPS
    var query = Firestore.instance
        .collection(FLAME_LINK_CONTENT)
        .where(FLAME_LINK_SCHEMA, isEqualTo: Schema.CROP)
        .where(FLAME_LINK_ENVIROMENT, isEqualTo: AppSettings.get().environment)
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
      if (crop.stagesPathReference != null) {
        for (var stagesPathReference in crop.stagesPathReference) {
          await Firestore.instance
              .document(stagesPathReference)
              .get()
              .then((stagesSnapshot) async {
            if (stagesSnapshot.data != null &&
                stagesSnapshot.data[documentFieldStatus] ==
                    DataStatus.PUBLISHED) {
              crop.addStage(StageEntity.stageFromDocument(stagesSnapshot));
            }
          });
        }
      }
      cropsWithStages.add(crop);
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
        var imagePath = EMPTY;
        if (imageSnapshot.data != null) {
          imagePath = await getImageDownloadURL(imageSnapshot);
        }
        crop.setImageUrl(imagePath);
        cropsEntitiesWithImagePath.add(crop);
      });
    }
    return cropsEntitiesWithImagePath;
  }

  Future<List<ArticleEntity>> getArticlesImagePath(
      List<ArticleEntity> articlesList) async {
    List<ArticleEntity> articlesEntitiesWithImagePath = List();

    for (var article in articlesList) {
      await Firestore.instance
          .document(article.imagePathReference)
          .get()
          .then((imageSnapshot) async {
        var imagePath = EMPTY;
        if (imageSnapshot.data != null) {
          imagePath = await getImageDownloadURL(imageSnapshot);
        }
        article.setImageUrl(imagePath);
        articlesEntitiesWithImagePath.add(article);
      });
    }
    return articlesEntitiesWithImagePath;
  }

  Future<String> getImageDownloadURL(DocumentSnapshot imageDocument) async {
    final sizePath = imageDocument.data[imageSizes].first[imagePath];
    final imageFileNamePath = imageDocument.data[imageFile];
    final flamelinkPath =
        IMAGE_BASE_PATH + '/' + sizePath + '/' + imageFileNamePath;
    final storageReference =
        FirebaseStorage.instance.ref().child(flamelinkPath);
    return await storageReference.getDownloadURL();
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
    ArticlesDirectoryEntity articlesDirectory = await query.getDocuments().then(
        (snapshot) => snapshot.documents
            .map((doc) =>
                ArticlesDirectoryEntity.featuredArticlesFromDocument(doc))
            .singleWhere((_) => true,
                orElse: () => ArticlesDirectoryEntity.empty()));

    return articlesDirectory;
  }

  Future<List<ArticleEntity>> getFeaturedArticles(
      List<String> articlesDirectory) async {
    List<ArticleEntity> listOfFeaturedArticles = List();

    if (articlesDirectory != null) {
      for (var articlePathReference in articlesDirectory) {
        await Firestore.instance
            .document(articlePathReference)
            .get()
            .then((featuredArticlesSnapshot) async {
          if (featuredArticlesSnapshot.data != null &&
              featuredArticlesSnapshot.data[documentFieldStatus] ==
                  DataStatus.PUBLISHED) {
            listOfFeaturedArticles.add(
                ArticleEntity.articleFromDocument(featuredArticlesSnapshot));
          }
        });
      }
    }
    return listOfFeaturedArticles;
  }

  Future<ArticleEntity> getRelatedArticles(ArticleEntity selectedArticle) async {
    if (selectedArticle.relatedArticlesPathReference != null) {
      selectedArticle.relatedArticles.clear();
      var relatedLimit = zero;

        for (var relatedArticlesPathReference in selectedArticle.relatedArticlesPathReference) {
          if (relatedLimit < ListOfRelatedArticles.LIMIT) {
            await Firestore.instance
                .document(relatedArticlesPathReference)
                .get()
                .then((relatedArticlesSnapshot) async {
              if (relatedArticlesSnapshot.data != null &&
                  relatedArticlesSnapshot.data[documentFieldStatus] ==
                      DataStatus.PUBLISHED) {
                selectedArticle.relatedArticles.add(ArticleEntity.articleFromDocument(relatedArticlesSnapshot));
                relatedLimit++;
              }
            });
        }
      }
    }
    return selectedArticle;
  }
}
