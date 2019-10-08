import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/EntityCollectionInterface.dart';
import 'package:farmsmart_flutter/model/entities/ImageEntity.dart';
import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';

import '../../FlameLink.dart';
import '../ImageRepositoryInterface.dart';

class ImageEntityFields {
  static String sizes = "sizes";
  static String width = "width";
  static String height = "height";
  static String path = "path";
  static String file = "file";
}

class _Strings {
  static const sizesFolder = "sized";
  static const pathDivider = "/";
}

class _Constants {
  static const int unkownSize = 0;
}

class FlamelinkImageEntity extends ImageEntity {
  final FlameLink _cms;
  final List<ImageEntity> otherSizes;
  FlamelinkImageEntity(FlameLink cms, int width, int height, String path,
      List<ImageEntity> otherSizes)
      : this._cms = cms,
        this.otherSizes = otherSizes,
        super(width, height, path, null) {
    this.urlProvider = FlameLinkImageProvider(_cms, this);
  }
}

ImageEntity _transform(FlameLink cms, DocumentSnapshot snapshot) {
  if(snapshot.data == null) {
     return FlamelinkImageEntity(cms, _Constants.unkownSize, _Constants.unkownSize,
      null, null);
  }
  final imageFileNamePath = castOrNull<String>(snapshot.data[ImageEntityFields.file]);
  
  final alternateSizesObjs =
      snapshot.data[ImageEntityFields.sizes].map((imageSize) {
    final path = _Strings.sizesFolder +
        _Strings.pathDivider +
        imageSize[ImageEntityFields.path] +
        _Strings.pathDivider +
        imageFileNamePath;
    final width = imageSize[ImageEntityFields.width];
    final height = imageSize[ImageEntityFields.height];
    return FlamelinkImageEntity(cms, width, height, path, []);
  }).toList();
  final alternateSizes = List<ImageEntity>.from(alternateSizesObjs);
  return FlamelinkImageEntity(cms, _Constants.unkownSize, _Constants.unkownSize,
      imageFileNamePath, alternateSizes);
}

class FlameLinkImageProvider implements ImageURLProvider {
  final FlameLink _cms;
  final FlamelinkImageEntity _entity;
  FlameLinkImageProvider(FlameLink cms, FlamelinkImageEntity entity)
      : _cms = cms,
        _entity = entity;

  @override
  Future<String> urlToFit({double width, double height}) {
    if(_entity.path == null){
      return null;
    }
    final originalImage = _cms.images(path: _entity.path);
    if (width != null && width != double.infinity) {
      final targetWidth = width.toInt();
      var alternateImages = _entity.otherSizes;
      alternateImages.sort((a, b) {
        return a.width.compareTo(b.width);
      });

      for (var image in alternateImages) {
        if ((image.width >= targetWidth)) {
          return _cms.images(path: image.path).getDownloadURL().then((value) {
            cacheURL(value, cacheIdentifier(width: width,height: height));
            return value;
          });
        }
      }
    }
    return originalImage.getDownloadURL().then((value) { 
      final url = value.toString();
      cacheURL(url, cacheIdentifier(height: height, width: width));
      return url;
    });
  }

  @override
  String cacheIdentifier({double width, double height}) {
    return _entity.path +
        ImageURLProvider.sizeIdentifier(
          width: width,
          height: height,
        );
  }

  @override
  String cachedUrlToFit({double width, double height}) {
    return cachedURL(cacheIdentifier(width: width, height: height));
  }
}

class ImageEntityCollectionFlamelink implements EntityCollection<ImageEntity> {
  final FlamelinkDocumentCollection _collection;

  ImageEntityCollectionFlamelink({FlamelinkDocumentCollection collection})
      : _collection = collection;

  @override
  Future<List<ImageEntity>> getEntities({int limit = 0}) {
    final imageFutures = _collection.getDocuments().then((documents) {
      return documents
          .map((document) => _transform(_collection.cms, document))
          .toList();
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
    final collection =
        FlamelinkDocumentCollection.list(cms: _cms, paths: paths);
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
