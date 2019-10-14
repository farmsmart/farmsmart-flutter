import 'dart:math';

import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/ImageEntity.dart';

import 'PathImageProvider.dart';

class MockImageEntity {
  final Random _rand;

  MockImageEntity({int seed = 0}) : _rand = Random(seed);

  ImageEntity build() {
    int width = _rand.nextInt(768);
    int height = _rand.nextInt(768);
    String path = "https://picsum.photos/";
    return ImageEntity(width, height, path, PathImageProvider(path));
  }

  List<ImageEntity> list({int count = 10}) {
    List<ImageEntity> images = [];
    for (var i = 0; i < count; i++) {
      images.add(build());
    }
    return images;
  }
}

class MockImageEntityCollection implements EntityCollection<ImageEntity> {
  @override
  Future<List<ImageEntity>> getEntities({int limit = 0}) {
    return Future.delayed(
        Duration(milliseconds: 500), () => MockImageEntity().list());
  }
}
