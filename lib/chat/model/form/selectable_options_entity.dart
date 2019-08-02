import 'package:farmsmart_flutter/chat/model/form/selectable_option_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'package:farmsmart_flutter/chat/model/form/selectable_options_entity.g.dart';

@JsonSerializable()
class SelectableOptionsEntity {
  SelectableOptionsEntity(
    this.maxSelection,
    this.options,
  );

  int maxSelection;
  List<SelectableOptionEntity> options;

  factory SelectableOptionsEntity.fromJson(Map<String, dynamic> json) =>
      _$SelectableOptionsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SelectableOptionsEntityToJson(this);
}
