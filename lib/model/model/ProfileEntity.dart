import 'package:farmsmart_flutter/model/model/ImageURLProvider.dart';

class ProfileEntity {
    final String id;
    final String name;
    final ImageURLProvider avatar;
    final Map<String,String> lastPlotInfo;

  ProfileEntity(this.id, this.name, this.avatar, this.lastPlotInfo);
}