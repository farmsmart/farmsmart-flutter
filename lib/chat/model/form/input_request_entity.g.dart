// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputRequestEntity _$InputRequestEntityFromJson(Map<String, dynamic> json) {
  return InputRequestEntity(
      json['type'] as String,
      json['uri'] as String,
      json['title'] as String,
      json['responseText'] as String,
      json['optional'] as bool,
      json['validationRegex'] as String,
      json['localStore'] as bool,
      json['inline'] as bool,
      json['args'] == null
          ? null
          : SelectableOptionsEntity.fromJson(
              json['args'] as Map<String, dynamic>));
}

Map<String, dynamic> _$InputRequestEntityToJson(InputRequestEntity instance) =>
    <String, dynamic>{
      'type': instance.type,
      'uri': instance.uri,
      'title': instance.title,
      'responseText': instance.responseText,
      'optional': instance.optional,
      'validationRegex': instance.validationRegex,
      'localStore': instance.localStore,
      'inline': instance.inline,
      'args': instance.args
    };
