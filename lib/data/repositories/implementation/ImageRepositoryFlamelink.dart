import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/model/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/data/model/ImageEntity.dart';
import 'package:farmsmart_flutter/data/model/ImageURLProvider.dart';
import '../ImageRepositoryInterface.dart';
import 'FlameLink.dart';


class ImageEntityFields {
    static String sizes = "sizes";
    static String width = "width";
    static String height = "height";
    static String path = "path";
    static String file = "file";
}

class FlamelinkImageEntity extends ImageEntity {
  final FlameLink _cms;
  FlamelinkImageEntity(FlameLink cms, int width, int height, String path, List<ImageEntity> otherSizes) : this._cms = cms, super(width, height, path, null, otherSizes) {
    this.urlProvider = FlameLinkImageProvider(_cms, this);
  }
} 

ImageEntity _transform(FlameLink cms, DocumentSnapshot snapshot) {
    final imageFileNamePath = snapshot.data[ImageEntityFields.file];
    
    final alternateSizesObjs = snapshot.data[ImageEntityFields.sizes].map((imageSize) {
      final path = imageSize[ImageEntityFields.path] + "/sized/" + imageFileNamePath;
      final width = imageSize[ImageEntityFields.width];
      final height = imageSize[ImageEntityFields.height];
      return FlamelinkImageEntity(cms, width, height, path, []);
    }).toList();
    final alternateSizes = List<ImageEntity>.from(alternateSizesObjs);
    return FlamelinkImageEntity(cms ,0, 0, imageFileNamePath, alternateSizes);
}

class FlameLinkImageProvider implements ImageURLProvider {
  final FlameLink _cms;
  final ImageEntity _entity;
  FlameLinkImageProvider(FlameLink cms, ImageEntity entity) : _cms = cms, _entity = entity;

  @override
  Future<String> urlToFit({double width, double height}) {
    //TODO: use other sizes. Here we can use the image entity size list to grab the right sized image
    final storageReference = _cms.images(path: _entity.path); 
    return storageReference.getDownloadURL().then((value) => value.toString());
  }
  
}

class ImageEntityCollectionFlamelink implements EntityCollection<ImageEntity> {
  final FlamelinkDocumentCollection _collection;

  ImageEntityCollectionFlamelink({FlamelinkDocumentCollection collection})
      :_collection = collection;

  @override
  Future<List<ImageEntity>> getEntities({int limit = 0}) {
    final imageFutures = _collection.getDocuments().then((documents) { 
      return documents.map((document) => _transform(_collection.cms, document)).toList(); 
      });
    return Future.value(imageFutures);
  }
}

class ImageRepositoryFlameLink implements ImageRepositoryInterface {

  final FlameLink _cms;

  ImageRepositoryFlameLink(FlameLink cms) : _cms = cms;

  @override
  Future<ImageEntity> get(String uri) {
     if (uri.isEmpty) {
      return null;
    }
    final baseCollection = _cms.files();
    return baseCollection
        .document(uri)
        .get()
        .then((snapshot) => _transform(_cms, snapshot));
  }

  @override
  Future<List<ImageEntity>> getImages(List<String> paths) {
    final collection = FlamelinkDocumentCollection.list(cms: _cms, paths: paths);
    return ImageEntityCollectionFlamelink(collection: collection).getEntities();
  }

  @override
  Stream<ImageEntity> observe(String uri) {
    if (uri.isEmpty) {
      return null;
    }
    final baseCollection = _cms.files();
    final _typeTransform =
        StreamTransformer<DocumentSnapshot, ImageEntity>.fromHandlers(
            handleData: (snapshot, sink) {
               sink.add(_transform(_cms, snapshot));
    });
    return baseCollection.document(uri).snapshots().transform(_typeTransform);
  }

  @override
  Future<String> getURL(ImageEntity image) {
    final storageReference = _cms.images(path: image.path);
    return storageReference.getDownloadURL();
  }

}
