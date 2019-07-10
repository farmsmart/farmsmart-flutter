import 'package:farmsmart_flutter/data/firebase_const.dart';
import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/stage_entity.dart';
import 'package:flutter/foundation.dart';

@Deprecated('This file is deprecated, the directory implementtation detail is now hidden in the Article Repository implementation.')
class ArticlesDirectoryRepository {
  static final ArticlesDirectoryRepository _articlesDir =
      ArticlesDirectoryRepository._internal();

  FireStoreManager _firestoreManager;

  static ArticlesDirectoryRepository get() {
    return _articlesDir;
  }

  Future<ArticlesDirectoryEntity> getArticlesWithImages() async {
    Stopwatch sw = Stopwatch();
    sw.start();
    ArticlesDirectoryEntity directory = await _getDirectory();
    debugPrint('getDirectory() ${sw.elapsed.inMilliseconds} ms ');
    sw.reset();
    List<ArticleEntity> articles = await _getListOfArticles(directory);
    debugPrint('getArticlesWithoutImages() ${sw.elapsed.inMilliseconds} ms ');
    sw.reset();
    await _getListOfArticlesWithImages(articles);
    debugPrint('getArticleImages() ${sw.elapsed.inMilliseconds} ms ');
    sw.stop();
    directory.articles = articles;
    return directory;
  }

  Future<ArticleEntity> getRelatedArticles(ArticleEntity article) async {
    return Future.value(null); // LH this file is deprecated
  }

  Future<StageEntity> getStageRelatedArticles(StageEntity stage) async {
    Stopwatch sw = Stopwatch();
    sw.start();
    List<ArticleEntity> relatedArticles = await _getListOfRelatedArticles(
        stage.stageRelatedArticlesPathReference, ListOfRelatedArticles.LIMIT);
    debugPrint('getStageRelatedArticles() ${sw.elapsed.inMilliseconds} ms ');
    sw.reset();
    await _getListOfArticlesWithImages(relatedArticles);
    stage.stageRelatedArticles = relatedArticles;
    debugPrint(
        'getStageRelatedArticleImages() ${sw.elapsed.inMilliseconds} ms ');
    sw.stop();
    return stage;
  }

  ArticlesDirectoryRepository._internal() {
    _firestoreManager = FireStoreManager.get();
  }

  Future<ArticlesDirectoryEntity> _getDirectory() {
    return _firestoreManager.getArticlesDirectory();
  }

  Future<List<ArticleEntity>> _getListOfArticles(
      ArticlesDirectoryEntity featuredDirectoryWithoutArticles) {
    return _firestoreManager
        .fetchArticles(featuredDirectoryWithoutArticles.articlesPathReference);
  }


  /// Attaches images to supplied articles
  Future<dynamic> _getListOfArticlesWithImages(
      List<ArticleEntity> articlesWithoutImages) {
    return Future.value([]);// _firestoreManager.getArticlesImagePath(articlesWithoutImages);
  }

  Future<List<ArticleEntity>> _getListOfRelatedArticles(
      List<String> articleReferences, int limit) async {
    return _firestoreManager.fetchArticlesByLimit(articleReferences, limit);
  }

  Future<ArticleEntity> getSingleArticle(String articleID) async {
    ArticleEntity articleEntity = await _firestoreManager.getArticleById(articleID);
    await _getListOfArticlesWithImages([articleEntity]);
    return articleEntity;
  }
}
