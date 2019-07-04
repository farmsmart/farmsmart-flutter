import 'package:cloud_firestore/cloud_firestore.dart';

class FlamelinkMeta {
  static const metaFieldName = "_fl_meta_";
  final String createdBy;
  final Timestamp createdDate;
  final Timestamp modified;
  final String locale;
  final String docId;
  final String env;

  const FlamelinkMeta({this.createdBy, this.createdDate, this.modified, this.locale, this.docId, this.env}) ;
}