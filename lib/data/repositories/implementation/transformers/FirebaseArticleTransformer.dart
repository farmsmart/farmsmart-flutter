
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/entities_const.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/FlameLinkMetaTransformer.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/FlamelinkMeta.dart';
import 'package:farmsmart_flutter/model/enums.dart';

class FlamelinkArticleTransformer implements ObjectTransformer<DocumentSnapshot, ArticleEntity> {
  final ObjectTransformer<DocumentSnapshot,FlamelinkMeta> _metaTransformer;

  FlamelinkArticleTransformer({ObjectTransformer<DocumentSnapshot,FlamelinkMeta> metaTransformer = const FlamelinkMetaTransformer()}) : this._metaTransformer = metaTransformer;

  @override
  ArticleEntity transform({DocumentSnapshot from}) {
    final meta = _metaTransformer.transform(from: from);
    return ArticleEntity(
          id: from.data[ID],
          content: from.data[CONTENT],
          status: statusValues.map[from.data[STATUS]],
          summary: from.data[SUMMARY],
          title: from.data[TITLE],
          published: meta.createdDate );
  }
}