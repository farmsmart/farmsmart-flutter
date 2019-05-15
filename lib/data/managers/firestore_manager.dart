import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/model/crop_entity.dart';
import 'package:farmsmart_flutter/data/model/stage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';

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
        .where(FLAME_LINK_ENVIROMENT,
            isEqualTo: FirestoreEnvironment.PRODUCTION)
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
            if (stagesSnapshot.data != null && stagesSnapshot.data["status"] == DataStatus.PUBLISHED) {
              crop.addStage(Stage.stageFromDocument(stagesSnapshot));
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
        var imagePath = "";
        if (imageSnapshot.data != null) {
          imagePath = await getImageDownloadURL(imageSnapshot);
        }
        crop.setImageUrl(imagePath);
        cropsEntitiesWithImagePath.add(crop);
      });
    }
    return cropsEntitiesWithImagePath;
  }


  Future<List<ArticleEntity>> getArticles() async {
    List<ArticleEntity> articlesEntities;

    // Filters defined by product definition. - ARTICLES
    var query = Firestore.instance
        .collection(FLAME_LINK_CONTENT)
        .where(FLAME_LINK_SCHEMA, isEqualTo: Schema.ARTICLE)
        .where(FLAME_LINK_ENVIROMENT, isEqualTo: FirestoreEnvironment.PRODUCTION)
        .where(FLAME_LINK_LOCALE, isEqualTo: Locale.EN_US)
        .where(PUBLICATION_STATUS, isEqualTo: DataStatus.PUBLISHED);

    await query.getDocuments().then((snapshot) {
      articlesEntities = snapshot.documents.map((articleDocument) {
        return ArticleEntity.articleFromDocument(articleDocument);
      }).toList();
    });
    return articlesEntities;
  }

  Future<List<ArticleEntity>> getArticlesImagePath(List<ArticleEntity> articlesList) async {
    List<ArticleEntity> articlesEntitiesWithImagePath = List();

    for (var article in articlesList) {
      await Firestore.instance
          .document(article.imagePathReference)
          .get()
          .then((imageSnapshot) async {
        var imagePath = "";
        if(imageSnapshot.data != null) {
          imagePath = await getImageDownloadURL(imageSnapshot);
        }
        article.setImageUrl(imagePath);
        articlesEntitiesWithImagePath.add(article);
      });
    }
    return articlesEntitiesWithImagePath;
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

  ////////////////// NEW ARTICLES DIRECTORY /////////////////

  // GET ARTICLES DIRECTORY
  Future<ArticlesDirectoryEntity> getArticlesDirectory() async {
    ArticlesDirectoryEntity articlesDirectory;

    var query = Firestore.instance
        .collection(FLAME_LINK_CONTENT)
        .where(FLAME_LINK_SCHEMA, isEqualTo: Schema.ARTICLE_DIRECTORY)
        .where(FLAME_LINK_SCHEMA_TYPE, isEqualTo: SchemaType.SINGLE)
        .where(FLAME_LINK_ENVIROMENT, isEqualTo: FirestoreEnvironment.PRODUCTION)
        .where(FLAME_LINK_LOCALE, isEqualTo: Locale.EN_US);

    // TODO: First problem here
    await query.getDocuments().then((snapshot) {
      articlesDirectory = snapshot.documents.map((articlesDirectoryDocument) {
        return ArticlesDirectoryEntity.featuredArticlesFromDocument(
            articlesDirectoryDocument);
      }).first;
  });
    return articlesDirectory;
}

// GET FEATURED ARTICLES
Future <ArticlesDirectoryEntity> getFeaturedArticles(ArticlesDirectoryEntity articlesDirectory) async {
      ArticlesDirectoryEntity articledirectoryWithFeaturedArticles;

      if (articlesDirectory.articlesPathReference != null) {
        for (var articlePathReference in articlesDirectory.articlesPathReference) {
          await Firestore.instance
              .document(articlePathReference)
              .get()
              .then((featuredArticlesSnapshot) async {
            if (featuredArticlesSnapshot.data != null && featuredArticlesSnapshot.data["status"] == DataStatus.PUBLISHED) {
              articlesDirectory.addArticle(ArticleEntity.articleFromDocument(featuredArticlesSnapshot));
            }
          });
        }
      }
      articledirectoryWithFeaturedArticles = articlesDirectory;
      return articledirectoryWithFeaturedArticles;
  }
}
