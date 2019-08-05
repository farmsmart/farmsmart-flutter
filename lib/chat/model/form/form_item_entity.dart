import 'package:json_annotation/json_annotation.dart';
import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/media_item_entity.dart';

part 'package:farmsmart_flutter/chat/model/form/form_item_entity.g.dart';

@JsonSerializable()
class FormItemEntity {
  FormItemEntity(this.text, this.media, this.inputRequest, this.sender,
      this.sentiment, this.senderMedia);

  String text;
  MediaItemEntity media;
  InputRequestEntity inputRequest;
  String sender;
  String sentiment;
  MediaItemEntity senderMedia;

  factory FormItemEntity.fromJson(Map<String, dynamic> json) =>
      _$FormItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FormItemEntityToJson(this);
}
