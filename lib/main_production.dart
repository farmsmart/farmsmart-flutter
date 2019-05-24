import 'package:farmsmart_flutter/main_common.dart';
import 'package:farmsmart_flutter/data/firebase_const.dart';

void main() async{

  // Write to shared preference
  writeEnvPreference(FirestoreEnvironment.PRODUCTION);

  bootstrap();
}


