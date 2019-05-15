import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';

class ArticlesRepository {
  static final ArticlesRepository _repo = ArticlesRepository._internal();

  FireStoreManager _firestoreManager;

  static ArticlesRepository get() {
    return _repo;
  }

  ArticlesRepository._internal() {
    _firestoreManager = FireStoreManager.get();
  }

  Future<List<ArticleEntity>> getListOfArticles(){
    return _firestoreManager.getArticles();
  }

  Future<List<ArticleEntity>> getListOfArticlesWithImages(List<ArticleEntity> articlesWithoutImages) {
    return _firestoreManager.getArticlesImagePath(articlesWithoutImages);
  }
}