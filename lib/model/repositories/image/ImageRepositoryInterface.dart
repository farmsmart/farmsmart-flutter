import 'package:farmsmart_flutter/model/entities/ImageEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';


class _Strings {
  static const prefix = "cache_";
} 

SharedPreferences _prefs;

Future<void> startURLCache() {
  return SharedPreferences.getInstance().then((prefs){
      _prefs = prefs;
    });
}

String cachedURL(String identifier) {  
  return _prefs?.getString(_Strings.prefix + identifier);
}

void cacheURL(String url, String identifier) {
  _prefs?.setString(_Strings.prefix + identifier, url);
}

abstract class ImageRepositoryInterface {
  Future<List<ImageEntity>> getImages(List<String> paths);
  Future<ImageEntity> get(String path);
  Stream<ImageEntity> observe(String path);
  Future<String> getURL(ImageEntity image);
}