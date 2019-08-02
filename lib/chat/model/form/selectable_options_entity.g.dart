// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selectable_options_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelectableOptionsEntity _$SelectableOptionsEntityFromJson(
    Map<String, dynamic> json) {
  return SelectableOptionsEntity(
      json['maxSelection'] as int,
      (json['options'] as List)
          ?.map((e) => e == null
              ? null
              : SelectableOptionEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SelectableOptionsEntityToJson(
        SelectableOptionsEntity instance) =>
    <String, dynamic>{
      'maxSelection': instance.maxSelection,
      'options': instance.options
    };
