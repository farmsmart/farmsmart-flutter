import 'package:json_annotation/json_annotation.dart';

import 'selectable_option_media_entity.dart';

part 'package:farmsmart_flutter/chat/model/form/selectable_option_entity.g.dart';

@JsonSerializable()
class SelectableOptionEntity {
  SelectableOptionEntity(
    this.id,
    this.title,
    this.description,
    this.responseText,
    this.media,
  );

  String id;
  String title;
  String description;
  String responseText;
  SelectableOptionMediaEntity media;

  factory SelectableOptionEntity.fromJson(Map<String, dynamic> json) =>
      _$SelectableOptionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SelectableOptionEntityToJson(this);
}
