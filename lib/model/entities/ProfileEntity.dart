import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';

class ProfileEntity {
  final String id;
  final String uri;
  final String name;
  final ImageURLProvider avatar;
  final Map<String, Map<String, String>> lastPlotInfo;

  ProfileEntity(
    this.id,
    this.uri,
    this.name,
    this.avatar,
    this.lastPlotInfo,
  );
}
