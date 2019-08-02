import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';
import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';

import 'package:farmsmart_flutter/chat/repository/form/ChatRepository.dart';
import 'package:farmsmart_flutter/chat/repository/form/datasource/JSONDatasource.dart';

class JSONFileFormRepository implements ChatRepository {
  static const int DEFAULT_LIMIT = 0;

  final Future<FormEntity> _formEntity;

  JSONFileFormRepository({
    BuildContext context,
    File file,
  }) : this._formEntity =
            JSONDataSource(context: context, file: file).getDataFromJSON();

  @override
  Future<FormEntity> getForm() {
    return _formEntity;
  }

  @override
  Future<List<FormItemEntity>> getFormItems() {
    return _formEntity.then((formEntity) {
      return formEntity.items;
    });
  }

  @override
  Future<FormItemEntity> getFormItem(int position) {
    return _formEntity.then((formEntity) {
      return (formEntity.items.isNotEmpty && formEntity.items.length > position)
          ? formEntity.items[position]
          : null;
    });
  }
}
