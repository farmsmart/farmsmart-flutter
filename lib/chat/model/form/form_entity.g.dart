// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormEntity _$FormEntityFromJson(Map<String, dynamic> json) {
  return FormEntity(
      json['uid'] as String,
      json['title'] as String,
      json['subtitle'] as String,
      json['origin'] as String,
      (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : FormItemEntity.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['formResponse'] == null
          ? null
          : FormResponseEntity.fromJson(
              json['formResponse'] as Map<String, dynamic>),
      json['processMessage'] as String,
      json['processComplete'] as String);
}

Map<String, dynamic> _$FormEntityToJson(FormEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'origin': instance.origin,
      'items': instance.items,
      'formResponse': instance.formResponse,
      'processMessage': instance.processMessage,
      'processComplete': instance.processComplete
    };
