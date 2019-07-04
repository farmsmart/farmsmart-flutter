import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/data/bloc/Transformer.dart';
import 'package:farmsmart_flutter/data/repositories/implementation/FlamelinkMeta.dart';

class _Fields {
  static const createdBy = "createdBy";
  static const createdDate = "createdDate";
  static const modified = "lastModifiedDate";
  static const locale = "locale";
  static const docId = "docId";
  static const env = "env";
}

class FlamelinkMetaTransformer
    implements ObjectTransformer<DocumentSnapshot, FlamelinkMeta> {
      const FlamelinkMetaTransformer();
  @override
  FlamelinkMeta transform({DocumentSnapshot from}) {
    final metaData = from[FlamelinkMeta.metaFieldName];
    if (metaData == null) {
      return null;
    }
    return FlamelinkMeta(
        createdBy: metaData[_Fields.createdBy],
        createdDate: Timestamp.now(),
        modified: Timestamp.now(),
        locale: metaData[_Fields.locale],
        docId: metaData[_Fields.docId],
        env: metaData[_Fields.env]);
  }
}
