import 'package:farmsmart_flutter/model/entities/ImageEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';

Map<String,String> _imageURLCache = {};

SharedPreferences _prefs;

Future<void> startURLCache() {
  return SharedPreferences.getInstance().then((prefs){
      _prefs = prefs;
    });
}

String cachedURL(String identifier) {  
  return _prefs?.getString("cache_" + identifier);
  //return _imageURLCache[identifier];
}

void cacheURL(String url, String identifier) {
  _prefs?.setString("cache_" + identifier, url);
//  _imageURLCache[identifier] = url;
}

abstract class ImageRepositoryInterface {
  Future<List<ImageEntity>> getImages(List<String> paths);
  Future<ImageEntity> get(String path);
  Stream<ImageEntity> observe(String path);
  Future<String> getURL(ImageEntity image);
}