import 'package:json_annotation/json_annotation.dart';

part 'package:farmsmart_flutter/chat/model/form/media_item_entity.g.dart';

@JsonSerializable()
class MediaItemEntity {
  MediaItemEntity(this.uri, this.mimeType);

  String uri;
  String mimeType;

  factory MediaItemEntity.fromJson(Map<String, dynamic> json) =>
      _$MediaItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MediaItemEntityToJson(this);
}
