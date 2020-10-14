import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';

class ImageEntity {
    final int width;
    final int height;
    final String path;
    ImageURLProvider urlProvider;
  ImageEntity(this.width, this.height, this.path, this.urlProvider);
}
