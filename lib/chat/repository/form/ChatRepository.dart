import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';

abstract class ChatRepository {
  Future<List<FormItemEntity>> getFormItems();

  Future<FormEntity> getForm();

  Future<FormItemEntity> getFormItem(int position);
}
