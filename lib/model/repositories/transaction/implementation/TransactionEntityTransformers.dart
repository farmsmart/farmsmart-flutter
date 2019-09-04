import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/TransactionAmount.dart';
import 'package:farmsmart_flutter/model/entities/TransactionEntity.dart';

class _Fields {
  static const tag = "tag";
  static const description = "description";
  static const timestamp = "timestamp";
  static const amount = "amount";
}

class DocumentToTransactionEntityTransformer
    extends ObjectTransformer<DocumentSnapshot, TransactionEntity> {
  @override
  TransactionEntity transform({DocumentSnapshot from}) {
    final data = from.data;
    final uri = castOrNull<String>(from.reference.path);
    final tag = castOrNull<String>(data[_Fields.tag]);
    final description = castOrNull<String>(data[_Fields.description]);
    final timestamp = castOrNull<Timestamp>(data[_Fields.timestamp])?.toDate();
    final value = castOrNull<String>(data[_Fields.amount]);
    return TransactionEntity(uri, TransactionAmount(value, false), tag, description, timestamp);
  }
}

class TransactionEntityToDocumentTransformer
    extends ObjectTransformer<TransactionEntity, Map<String, dynamic>> {
  @override
  Map<String, dynamic> transform({TransactionEntity from}) {
    return {
      _Fields.tag: from.tag,
      _Fields.description: from.description,
      _Fields.timestamp: Timestamp.fromDate(from.timestamp),
      _Fields.amount:from.amount.rawString(),  //LH we save as a string to ensure we preserve the Decimal number and not involve floating points
    };
  }
}
