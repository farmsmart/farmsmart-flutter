import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/repositories/FlameLink.dart';
import 'data/repositories/flamelink_repository_provider.dart';
import 'flavors/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
    environment: Environment.production,
    buildFlavor: 'Production',
    child: FarmSmartApp(),
    repositoryProvider: FlameLinkRepositoryProvider(),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  return runApp(configuredApp);
}
