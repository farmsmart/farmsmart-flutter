import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Testing...', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      final health = await driver.checkHealth();
      if (health.status != HealthStatus.ok) {
        throw('Driver setup failed');
      }
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('first test', () async {
      final appBar = find.byValueKey('appBar');
      await driver.waitFor(appBar, timeout: const Duration(seconds: 3));
    });
  });
}