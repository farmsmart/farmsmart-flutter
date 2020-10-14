import 'package:json_annotation/json_annotation.dart';
import 'package:farmsmart_flutter/chat/model/form/selectable_options_entity.dart';

part 'package:farmsmart_flutter/chat/model/form/input_request_entity.g.dart';

@JsonSerializable()
class InputRequestEntity {
  InputRequestEntity(
    this.type,
    this.uri,
    this.title,
    this.responseText,
    this.optional,
    this.validationRegex,
    this.localStore,
    this.inline,
    this.args,
  );

  String type;
  String uri;
  String title;
  String responseText;
  bool optional;
  String validationRegex;
  bool localStore;
  bool inline;
  SelectableOptionsEntity args;

  factory InputRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$InputRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$InputRequestEntityToJson(this);
}
