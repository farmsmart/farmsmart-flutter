import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';

class JSONDataSource {
  final BuildContext _context;
  final File _file;

  JSONDataSource({
    BuildContext context,
    File file,
  })  : this._context = context,
        this._file = file;

  Future<FormEntity> getDataFromJSON() async {
    String data = await DefaultAssetBundle.of(_context).loadString(_file.path);
    return FormEntity.fromJson(json.decode(data));
  }
}
