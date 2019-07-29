import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data/repositories/FlameLink.dart';
import 'flavors/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
    environment: Environment.development,
    buildFlavor: 'Development',
    child: FarmSmartApp(),
    isMockData: false,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  return runApp(configuredApp);
}
