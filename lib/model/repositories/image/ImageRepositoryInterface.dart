import 'package:farmsmart_flutter/model/model/ImageEntity.dart';

abstract class ImageRepositoryInterface {
  Future<List<ImageEntity>> getImages(List<String> paths);
  Future<ImageEntity> get(String path);
  Stream<ImageEntity> observe(String path);
  Future<String> getURL(ImageEntity image);
}