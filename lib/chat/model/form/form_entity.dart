import 'package:json_annotation/json_annotation.dart';

import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/form_response_entity.dart';

part 'package:farmsmart_flutter/chat/model/form/form_entity.g.dart';

@JsonSerializable()
class FormEntity {
  FormEntity(this.uid, this.title, this.subtitle, this.origin, this.items,
      this.formResponse, this.processMessage, this.processComplete);

  String uid;
  String title;
  String subtitle;
  String origin;
  List<FormItemEntity> items;
  FormResponseEntity formResponse;
  String processMessage;
  String processComplete;

  factory FormEntity.fromJson(Map<String, dynamic> json) =>
      _$FormEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FormEntityToJson(this);
}
