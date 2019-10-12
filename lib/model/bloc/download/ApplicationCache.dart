import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class OfflineCacheManager extends BaseCacheManager {
  static const key = "offlineCachedImageData";

  static OfflineCacheManager _instance;

  factory OfflineCacheManager() {
    if (_instance == null) {
      _instance = new OfflineCacheManager._();
    }
    return _instance;
  }

  OfflineCacheManager._() : super(key, maxAgeCacheObject: Duration(days: 365), maxNrOfCacheObjects:4096,);

  Future<String> getFilePath() async {
    var directory = await getApplicationSupportDirectory();
    return p.join(directory.path, key);
  }
}