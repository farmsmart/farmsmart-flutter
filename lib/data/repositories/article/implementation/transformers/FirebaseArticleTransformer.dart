
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/model/entities_const.dart';
import 'package:farmsmart_flutter/model/enums.dart';

import '../../../FlamelinkMeta.dart';
import '../FlameLinkMetaTransformer.dart';

class FlamelinkArticleTransformer implements ObjectTransformer<DocumentSnapshot, ArticleEntity> {
  final ObjectTransformer<DocumentSnapshot,FlamelinkMeta> _metaTransformer;

  FlamelinkArticleTransformer({ObjectTransformer<DocumentSnapshot,FlamelinkMeta> metaTransformer = const FlamelinkMetaTransformer()}) : this._metaTransformer = metaTransformer;

  @override
  ArticleEntity transform({DocumentSnapshot from}) {
    final meta = _metaTransformer.transform(from: from);
    final id = castOrNull<String>(from.data[ID]);
    final content = castOrNull<String>(from.data[CONTENT]);
    final status = castOrNull<String>(from.data[STATUS]);
    final summary = castOrNull<String>(from.data[SUMMARY]);
    final title = castOrNull<String>(from.data[TITLE]);
    return ArticleEntity(
          id: id,
          content: content,
          status: statusValues.map[status],
          summary: summary,
          title: title,
          published: meta.createdDate );
  }
}