import 'package:flutter/material.dart';

import 'model/repositories/FlameLink.dart';
import 'model/repositories/flamelink_repository_provider.dart';
import 'flavors/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
    environment: Environment.production, //TODO: change back to dev
    buildFlavor: 'Development',
    child: FarmSmartApp(),
    repositoryProvider: FlameLinkRepositoryProvider(),
  );



  return runApp(configuredApp);
}
