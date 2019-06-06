import 'package:farmsmart_flutter/data/managers/firestore_manager.dart';
import 'package:farmsmart_flutter/data/model/articles_directory_entity.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';

class ArticlesDirectoryRepository {
  static final ArticlesDirectoryRepository _articlesDir =
      ArticlesDirectoryRepository._internal();

  FireStoreManager _firestoreManager;

  static ArticlesDirectoryRepository get() {
    return _articlesDir;
  }

  ArticlesDirectoryRepository._internal() {
    _firestoreManager = FireStoreManager.get();
  }

  Future<ArticlesDirectoryEntity> getDirectory() {
    return _firestoreManager.getArticlesDirectory();
  }

  Future<List<ArticleEntity>> getListOfArticles(
      ArticlesDirectoryEntity featuredDirectoryWithoutArticles) {
    return _firestoreManager.getFeaturedArticles(
        featuredDirectoryWithoutArticles.articlesPathReference);
  }

  Future<ArticleEntity> getArticleById(String artcleId) {
    return _firestoreManager.getArticleById(artcleId);
  }

  Future<ArticleEntity> getArticleImagePath(ArticleEntity articleEntity) {
    return _firestoreManager.getArticleImagePath(articleEntity);
  }

  Future<ArticleEntity> getArticleWithImageById(String articleId) async {
    ArticleEntity articleEntity = await getArticleById(articleId);
    return await getArticleImagePath(articleEntity);
  }

  Future<List<ArticleEntity>> getListOfArticlesWithImages(
      List<ArticleEntity> articlesWithoutImages) {
    return _firestoreManager.getArticlesImagePath(articlesWithoutImages);
  }

  Future<ArticleEntity> getArticleWithImage(ArticleEntity articleWithoutImage) {
    return _firestoreManager.getArticleImagePath(articleWithoutImage);
  }

  Future<ArticlesDirectoryEntity> getArticlesWithImages() async {
    ArticlesDirectoryEntity directory = await getDirectory();
    List<ArticleEntity> articles = await getListOfArticles(directory);
    List<ArticleEntity> articlesWithImage =
        await getListOfArticlesWithImages(articles);
    directory.articles = articlesWithImage;
    return directory;
  }

  Future<ArticleEntity> getSingleArticle(String articleID) async {
    ArticleEntity articleEntity = await _firestoreManager.getArticleById(articleID);
    ArticleEntity articleWithImage = await _firestoreManager.getArticleImagePath(articleEntity);
    return articleWithImage;
  }
}
