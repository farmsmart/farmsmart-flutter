import 'package:flutter/material.dart';

import 'model/repositories/flamelink_repository_provider.dart';
import 'flavors/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
    environment: 'development',
    buildFlavor: 'Development',
    child: FarmSmartApp(),
    repositoryProvider: FlameLinkRepositoryProvider(),
  );



  return runApp(configuredApp);
}
