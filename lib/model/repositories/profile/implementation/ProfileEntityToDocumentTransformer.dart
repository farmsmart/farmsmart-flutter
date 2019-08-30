import 'package:farmsmart_flutter/model/bloc/Transformer.dart';
import 'package:farmsmart_flutter/model/entities/ProfileEntity.dart';


class _Fields {
  static const name = "name";
  static const plotInfo = "plotInfo";
}

class ProfileEntityToDocumentTransformer extends ObjectTransformer<ProfileEntity,Map<String,dynamic>> {

  @override
  Map<String,dynamic> transform({ProfileEntity from}) {
    return {_Fields.name:from.name, _Fields.plotInfo:from.lastPlotInfo};
  }
  
}