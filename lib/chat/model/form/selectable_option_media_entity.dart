import 'package:json_annotation/json_annotation.dart';

part 'package:farmsmart_flutter/chat/model/form/selectable_option_media_entity.g.dart';

@JsonSerializable()
class SelectableOptionMediaEntity {
  SelectableOptionMediaEntity(
    this.mimeType,
    this.uri,
  );

  String mimeType;
  String uri;

  factory SelectableOptionMediaEntity.fromJson(Map<String, dynamic> json) =>
      _$SelectableOptionMediaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SelectableOptionMediaEntityToJson(this);
}
