import 'package:json_annotation/json_annotation.dart';

part 'package:farmsmart_flutter/chat/model/form/form_response_entity.g.dart';

@JsonSerializable()
class FormResponseEntity {
  FormResponseEntity(this.type, this.uri, this.body);

  String type;
  String uri;
  dynamic body;

  factory FormResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$FormResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FormResponseEntityToJson(this);
}
