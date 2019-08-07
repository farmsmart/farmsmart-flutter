// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormResponseEntity _$FormResponseEntityFromJson(Map<String, dynamic> json) {
  return FormResponseEntity(
      json['type'] as String, json['uri'] as String, json['body']);
}

Map<String, dynamic> _$FormResponseEntityToJson(FormResponseEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'uri': instance.uri,
      'body': instance.body
    };
