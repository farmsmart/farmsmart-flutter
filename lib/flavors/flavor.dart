@Deprecated('Use app_config.dart instead')
class AppSettings {
  static final AppSettings _settingsManager =
  new AppSettings._internal();

  static AppSettings get() {
    return _settingsManager;
  }

  AppSettings._internal();

  String environment;
}