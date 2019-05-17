import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';

class ArticlesRepository {
  static final ArticlesRepository _repo = ArticlesRepository._internal();

  FireStoreManager _fireStoreManager;

  static ArticlesRepository get() {
    return _repo;
  }

  ArticlesRepository._internal() {
    _fireStoreManager = FireStoreManager.get();
  }

  Future<List<ArticleEntity>> getListOfArticles(){
    return _fireStoreManager.getArticles();
  }

  Future<List<ArticleEntity>> getListOfArticlesWithImages(List<ArticleEntity> articlesWithoutImages) {
    return _fireStoreManager.getArticlesImagePath(articlesWithoutImages);
  }
}