import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';

class DiscoverRepository {
  static final DiscoverRepository _repo = DiscoverRepository._internal();

  FireStoreManager _fireStoreManager;

  static DiscoverRepository get() {
    return _repo;
  }

  DiscoverRepository._internal() {
    _fireStoreManager = FireStoreManager.get();
  }

  Future<List<ArticleEntity>> getListOfArticles(){
    return _fireStoreManager.getArticles();
  }

  Future<List<ArticleEntity>> getListOfArticlesWithImages(List<ArticleEntity> articlesWithoutImages) {
    return _fireStoreManager.getArticlesImagePath(articlesWithoutImages);
  }
}