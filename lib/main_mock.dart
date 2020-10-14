import 'package:flutter/material.dart';

import 'model/repositories/mock_repository_provider.dart';
import 'flavors/app_config.dart';
import 'main.dart';

void main() {
  var configuredApp = AppConfig(
    environment: 'development',
    buildFlavor: 'Development',
    child: FarmSmartApp(),
    repositoryProvider: MockRepositoryProvider(),
  );

  return runApp(configuredApp);
}
