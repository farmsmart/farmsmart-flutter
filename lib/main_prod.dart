import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/bloc/ResetStateWidget.dart';
import 'model/repositories/flamelink_repository_provider.dart';
import 'flavors/app_config.dart';
import 'main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var configuredApp = AppConfig(
    environment: 'production',
    buildFlavor: 'Production',
    child: FarmSmartApp(),
    repositoryProvider: FlameLinkRepositoryProvider(),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  return runApp(ResetStateWidget(child: configuredApp));
}
