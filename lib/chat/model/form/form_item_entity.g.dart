// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormItemEntity _$FormItemEntityFromJson(Map<String, dynamic> json) {
  return FormItemEntity(
      json['text'] as String,
      json['media'] == null
          ? null
          : MediaItemEntity.fromJson(json['media'] as Map<String, dynamic>),
      json['inputRequest'] == null
          ? null
          : InputRequestEntity.fromJson(
              json['inputRequest'] as Map<String, dynamic>),
      json['sender'] as String,
      json['sentiment'] as String,
      json['senderMedia'] == null
          ? null
          : MediaItemEntity.fromJson(
              json['senderMedia'] as Map<String, dynamic>));
}

Map<String, dynamic> _$FormItemEntityToJson(FormItemEntity instance) =>
    <String, dynamic>{
      'text': instance.text,
      'media': instance.media,
      'inputRequest': instance.inputRequest,
      'sender': instance.sender,
      'sentiment': instance.sentiment,
      'senderMedia': instance.senderMedia
    };
