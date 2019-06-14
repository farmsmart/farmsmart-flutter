import 'package:farmsmart_flutter/flavors/flavor.dart';
import 'package:farmsmart_flutter/main_common.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';

void main() async{

  // Write to shared preference
  AppSettings.get().environment = (FirestoreEnvironment.DEVELOPMENT);

  bootstrap();
}

