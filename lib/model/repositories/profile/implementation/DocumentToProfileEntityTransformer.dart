
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';

class _Fields {
  static const name = "name";
  static const plotInfo = "plotInfo";
  static const ownerID = "plotInfo";
}

class DocumentToProfileEntityTransformer extends ObjectTransformer<DocumentSnapshot,ProfileEntity> {

  @override
  ProfileEntity transform({DocumentSnapshot from}) {
    final data = from.data;
    final name = castOrNull<String>(data[_Fields.name]);
    final plotInfo = castOrNull<Map<String,dynamic>>(data[_Fields.plotInfo]);
    final id = castOrNull<String>(from.documentID);
    return ProfileEntity(id,name,null,plotInfo,);
  }
  
}