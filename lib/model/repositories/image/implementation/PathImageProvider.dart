import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';

class PathImageProvider implements ImageURLProvider {
  final _path;

  PathImageProvider(this._path);
  @override
  Future<String> urlToFit({double width, double height}) {
    return Future.value(cachedUrlToFit(width: width, height: height));
  }

  @override
  String cacheIdentifier({double width, double height}) {
    return _path +
        ImageURLProvider.sizeIdentifier(
          width: width,
          height: height,
        );
  }

  @override
  String cachedUrlToFit({double width, double height}) {
    return _path;
  }
}