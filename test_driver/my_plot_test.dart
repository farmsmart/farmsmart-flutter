import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('My Plot', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      final health = await driver.checkHealth();
      if (health.status != HealthStatus.ok) {
        throw ('Driver setup failed');
      }
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('view list crops on My Plot', () async {
      final okra = find.byValueKey('Okra');
      await driver.waitFor(okra);

      final cowpeas = find.byValueKey('Cowpeas');
      await driver.scrollIntoView(cowpeas);
    });

    test('view crop details', () async {
      final detailsLink = find.text('DETAILS');
      await driver.tap(detailsLink);

      final cropDetailsText = find.text('Crop Details');
      await driver.waitFor(cropDetailsText);
    });

    test('view crop stage', () async {
      final stage = find.byValueKey('Preparation');
      await driver.scrollIntoView(stage);
      await driver.tap(stage);

      final stageTitleText = find.text('Preparation');
      await driver.waitFor(stageTitleText);
    });
  });
}
