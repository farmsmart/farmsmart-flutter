import 'package:farmsmart_flutter/model/entities/ImageEntity.dart';

Map<String,String> _imageURLCache = {};

String cachedURL(String identifier) {
  return _imageURLCache[identifier];
}

String cacheURL(String url, String identifier) {
  _imageURLCache[identifier] = url;
}

abstract class ImageRepositoryInterface {
  Future<List<ImageEntity>> getImages(List<String> paths);
  Future<ImageEntity> get(String path);
  Stream<ImageEntity> observe(String path);
  Future<String> getURL(ImageEntity image);
}