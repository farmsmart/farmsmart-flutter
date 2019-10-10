import 'dart:async';

import 'package:farmsmart_flutter/model/bloc/download/OfflineDownloader.dart';
import 'package:farmsmart_flutter/model/entities/loading_status.dart';
import 'package:farmsmart_flutter/ui/offline/OfflineDownloadPage.dart';

import '../ViewModelProvider.dart';

class OfflineDownloaderProvider
    implements ViewModelProvider<OfflineDownloadPageViewModel> {
  final OfflineDownloader _downloader;
  OfflineDownloadPageViewModel _snapshot;
  final _controller =
      StreamController<OfflineDownloadPageViewModel>.broadcast();

  OfflineDownloaderProvider(this._downloader);
  @override
  OfflineDownloadPageViewModel initial() {
    if (_snapshot == null) {
      _snapshot = _viewModel(status: LoadingStatus.SUCCESS);
    }
    return _snapshot;
  }

  @override
  OfflineDownloadPageViewModel snapshot() {
    return initial();
  }

  @override
  Stream<OfflineDownloadPageViewModel> stream() {
    return _controller.stream;
  }

  OfflineDownloadPageViewModel _viewModel(
      {LoadingStatus status, double progress = 0.0}) {
    return OfflineDownloadPageViewModel(status, _triggerDownload, progress);
  }

  void _triggerDownload() {
    _controller.add(
          _viewModel(status: LoadingStatus.LOADING, progress: 0));
    _downloader.downloadAll(complete: () {
      _controller.add(_viewModel(status: LoadingStatus.SUCCESS));
    }).listen((update) {
      _controller.add(
          _viewModel(status: LoadingStatus.LOADING, progress: update.progress));
    });
  }

  void dispose() {
    _controller.sink.close();
    _controller.close();
  }
}
