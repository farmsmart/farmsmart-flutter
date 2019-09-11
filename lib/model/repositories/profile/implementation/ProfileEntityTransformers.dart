
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:path_provider/path_provider.dart';

class _Fields {
  static const name = "name";
  static const plotInfo = "plotInfo";
  static const avatarPath = "avatarPath";
}

class _Constants {
  static final avatarPathSuffix = '_avatar.jpg';
}

class LocalProfileImageProvider implements ImageURLProvider {
  final String id;

  LocalProfileImageProvider(this.id);
  @override
  Future<String> urlToFit({double width, double height}) {
    return localAvatarPath(id);
  }

  static Future<String> localAvatarPath(String id) {
    return getApplicationDocumentsDirectory().then((directory){
       return '${directory.path}/${id}_${_Constants.avatarPathSuffix}';
    });
  }
}

class DocumentToProfileEntityTransformer extends ObjectTransformer<DocumentSnapshot,ProfileEntity> {

  @override
  ProfileEntity transform({DocumentSnapshot from}) {
    final data = from.data;
    final name = castOrNull<String>(data[_Fields.name]);
    final plotInfo = castMapOrNull<String,String>(data[_Fields.plotInfo]);
    final uri = castOrNull<String>(from.reference.path);
    final id = from.documentID;
    return ProfileEntity(id,uri,name,LocalProfileImageProvider(id),plotInfo,);
  }
  
}

class ProfileEntityToDocumentTransformer extends ObjectTransformer<ProfileEntity,Map<String,dynamic>> {

  @override
  Map<String,dynamic> transform({ProfileEntity from}) {
    return {_Fields.name:from.name, _Fields.plotInfo:from.lastPlotInfo};
  }
  
}