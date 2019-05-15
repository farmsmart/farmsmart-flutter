
import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';

class ArticlesDirectoryRepository {
  static final ArticlesDirectoryRepository _articlesDir = ArticlesDirectoryRepository._internal();

  FireStoreManager _firestoreManager;

  static ArticlesDirectoryRepository get() {
    return _articlesDir;
  }

  ArticlesDirectoryRepository._internal(){
    _firestoreManager = FireStoreManager.get();
  }

  Future<ArticlesDirectoryEntity> getDirectory(){
    return _firestoreManager.getArticlesDirectory();
  }

  Future<ArticlesDirectoryEntity> getListOfArticles(ArticlesDirectoryEntity featuredDirectoryWithoutArticles) {
    return _firestoreManager.getFeaturedArticles(featuredDirectoryWithoutArticles);
  }
}