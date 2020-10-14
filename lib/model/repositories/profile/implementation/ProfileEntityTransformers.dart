import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';
import 'package:path_provider/path_provider.dart';

class _Fields {
  static const name = "name";
  static const plotInfo = "plotInfo";
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
    return getApplicationDocumentsDirectory().then((directory) {
      return '${directory.path}/${id}_${_Constants.avatarPathSuffix}';
    });
  }

  @override
  String cacheIdentifier({double width, double height}) {
    return null;
  }

  @override
  String cachedUrlToFit({double width, double height}) {
    return null;
  }
}

class DocumentToProfileEntityTransformer
    extends ObjectTransformer<DocumentSnapshot, ProfileEntity> {
  @override
  ProfileEntity transform({DocumentSnapshot from}) {
    final data = from.data;
    final name = castOrNull<String>(data[_Fields.name]);
    final plotInfo = _getPlotInfoData(data[_Fields.plotInfo]);
    final uri = castOrNull<String>(from.reference.path);
    final id = from.documentID;
    return ProfileEntity(
      id,
      uri,
      name,
      LocalProfileImageProvider(id),
      plotInfo,
    );
  }

  Map<String, Map<String, String>> _getPlotInfoData(dynamic data) {
    Map<String, Map<String, String>> responseMap = {};
    data.forEach((key, value) => responseMap[castOrNull<String>(key)] =
        castMapOrNull<String, String>(value));
    return responseMap;
  }
}

class ProfileEntityToDocumentTransformer
    extends ObjectTransformer<ProfileEntity, Map<String, dynamic>> {
  @override
  Map<String, dynamic> transform({ProfileEntity from}) {
    return {
      _Fields.name: from.name,
      _Fields.plotInfo: from.lastPlotInfo,
    };
  }
}
