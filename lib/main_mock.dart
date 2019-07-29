import 'package:flutter/material.dart';

import 'data/repositories/FlameLink.dart';
import 'data/repositories/mock_repository_provider.dart';
import 'flavors/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
    environment: Environment.development,
    buildFlavor: 'Development',
    child: FarmSmartApp(),
    repositoryProvider: MockRepositoryProvider(),
  );

  return runApp(configuredApp);
}
