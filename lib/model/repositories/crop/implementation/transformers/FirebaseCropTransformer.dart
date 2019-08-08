import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/model/article_entity.dart';
import 'package:farmsmart_flutter/model/model/crop_entity.dart';
import 'package:farmsmart_flutter/model/model/enums.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/ImageRepositoryFlamelink.dart';

import '../../../FlameLink.dart';
import '../../../FlamelinkMeta.dart';



class _Fields {
  static String id = "id";
  static String status = "status";
  static String summary = "summary";
  static String name = "name";
  static String image = "image";
}

class FlamelinkCropTransformer
    extends ObjectTransformer<DocumentSnapshot, CropEntity> {
  final ObjectTransformer<DocumentSnapshot, FlamelinkMeta> _metaTransformer;
  final FlameLink _cms;

  FlamelinkCropTransformer(
      {FlameLink cms,
      ObjectTransformer<DocumentSnapshot, FlamelinkMeta> metaTransformer})
      : this._cms = cms,
        this._metaTransformer = metaTransformer;

  @override
  CropEntity transform({DocumentSnapshot from}) {
    final meta = _metaTransformer.transform(from: from);
    final id = castOrNull<String>(from.data[_Fields.id]);
    final statusString = castOrNull<String>(from.data[_Fields.status]);
    final summary = castOrNull<String>(from.data[_Fields.summary]);
    final name = castOrNull<String>(from.data[_Fields.name]);
    final published =
        (meta.createdDate != null) ? meta.createdDate.toDate() : null;
    final imageRefs = from.data[_Fields.image];
    ImageEntityCollectionFlamelink imageCollection;
    if (imageRefs != null) {
      imageCollection = ImageEntityCollectionFlamelink(
          collection: FlamelinkDocumentCollection.fromImageRefs(
        cms: _cms,
        paths: imageRefs,
      ));
    }
    final status = statusValues.map[statusString];
    final article = ArticleEntity(
      id: id,
      title: name,
      status: status,
      summary: summary,
      content: summary, //LH crops don´t have content 
      published: published,
    );
    article.images = imageCollection;
    return CropEntity(
      id: id,
      status: statusValues.map[status],
      name: name,
      article: article,
    );
  }
}
