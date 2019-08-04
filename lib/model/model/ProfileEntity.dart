import 'package:farmsmart_flutter/model/model/FactorEntity.dart';
import 'package:farmsmart_flutter/model/model/ImageURLProvider.dart';

class ProfileEntity {
    final String id;
    final String name;
    final ImageURLProvider avatar;
    final FactorEntity lastFactorProfile;

  ProfileEntity(this.id, this.name, this.avatar, this.lastFactorProfile);
}