import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';

class ProfileEntity {
  final String uri;
  final String name;
  final ImageURLProvider avatar;
  final Map<String, String> lastPlotInfo;

  ProfileEntity(
    this.uri,
    this.name,
    this.avatar,
    this.lastPlotInfo,
  );
}
