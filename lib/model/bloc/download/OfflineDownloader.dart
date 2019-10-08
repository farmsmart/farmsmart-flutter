import 'dart:async';

import 'package:farmsmart_flutter/model/entities/ImageEntity.dart';
import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/model/entities/crop_entity.dart';
import 'package:farmsmart_flutter/model/repositories/article/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/crop/CropRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/repositories/ratingEngine/RatingEngineRepositoryInterface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DownloadProgress {
  final double progress;
  final Error error;

  DownloadProgress(this.progress, this.error);
}

class OfflineDownloader {
  final _cacheManager = DefaultCacheManager();
  final ArticleRepositoryInterface _articleRepo;
  final CropRepositoryInterface _cropRepo;
  final RatingEngineRepositoryInterface _ratingRepo;

  StreamController<DownloadProgress> _controller =
      StreamController<DownloadProgress>.broadcast();

  OfflineDownloader(this._articleRepo, this._cropRepo, this._ratingRepo);

  Stream<DownloadProgress> dowloadImages(
      {List<ImageEntity> images, Function complete}) {
    final taskCount = images.length;
    int completeTasks = 0;
    List<Future> futures = [];
    for (var image in images) {
      if (image != null) {
        futures.add(image.urlProvider.urlToFit().then((url) {
          return _cacheManager.getSingleFile(url).then((_) {
            completeTasks++;
            print("downloaded " +
                completeTasks.toString() +
                " of" +
                taskCount.toString());
            _controller.add(DownloadProgress(completeTasks / taskCount, null));
          }, onError: (error) {
            completeTasks++;
            _controller.add(DownloadProgress(completeTasks / taskCount, error));
          });
        }));
      }
    }
    Future.wait(futures).then((_) {
      if (complete != null) {
        complete();
      }
    });
    return _controller.stream;
  }

  Stream<DownloadProgress> downloadAll({Function complete}) {
    _ratingRepo.getRatingInfo();
    _articleRepo.get().then((articles) {
      _articleImages(articles).then((articleImages) {
        _articleRepo
            .get(group: ArticleCollectionGroup.chatGroups)
            .then((chatGroupArticles) {
          _articleImages(chatGroupArticles).then((chatImages) {
            _cropRepo.get().then((crops) {
              _cropImages(crops).then((cropImages) {
                dowloadImages(images: articleImages + chatImages + cropImages);
              });
            });
          });
        });
      });
    });
    return _controller.stream;
  }

  Future<List<ImageEntity>> _articleImages(List<ArticleEntity> articles) {
    final futures = articles.map((article) {
      print(article.title);
      return article.images?.getEntities()?.then((images) {
        return images.where((image) {
          return image != null && image.path != null;
        }).toList();
      });
    }).where((value) {
      return value != null;
    });
    if (futures.isEmpty) {
      return Future.value([]);
    }
    return Future.wait(futures).then((lists) {
      return lists.reduce((a, b) {
        return (b != null) ? a + b : a;
      });
    });
  }

  Future<List<ImageEntity>> _cropImages(List<CropEntity> crops) {
    final cropImages = crops.map((crop) {
      return crop.images?.getEntities()?.then((images) {
        return images.where((image) {
          return image != null && image.path != null;
        }).toList();
      });
    }).where((object) {
      return object != null;
    }).toList();

    final stageImages = crops.map((crop) {
      return crop.stageArticles?.getEntities()?.then((articles) {
        return _articleImages(articles);
      });
    }).where((object) {
      return object != null;
    }).toList();

    return Future.wait(cropImages + stageImages).then((lists) {
      return lists.reduce((a, b) {
        return (b != null) ? a + b : a;
      });
    });
  }
}
