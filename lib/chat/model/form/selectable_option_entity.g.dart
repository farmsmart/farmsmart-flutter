// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selectable_option_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectableOptionEntity _$SelectableOptionEntityFromJson(
    Map<String, dynamic> json) {
  return SelectableOptionEntity(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['responseText'] as String,
      json['media'] == null
          ? null
          : SelectableOptionMediaEntity.fromJson(
              json['media'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SelectableOptionEntityToJson(
        SelectableOptionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'responseText': instance.responseText,
      'media': instance.media
    };
