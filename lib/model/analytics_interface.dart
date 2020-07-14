
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';



class AnalyticsEventTypes {
  static const impression = 'impression';
  static const interaction = 'interaction';
}

class _Constants {
  static const typeField = 'type';
}

class AnalyticsEvent {
  final String name;
  final Map<String,dynamic> parameters;

  AnalyticsEvent(this.name, {this.parameters});

  factory AnalyticsEvent.impression(String name) {
    return AnalyticsEvent(name, parameters: {_Constants.typeField:AnalyticsEventTypes.impression});
  }

  factory AnalyticsEvent.interaction(String name) {
    return AnalyticsEvent(name, parameters: {_Constants.typeField:AnalyticsEventTypes.interaction});
  }
}

abstract class AnalyticsInterface {
  static AnalyticsInterface of(BuildContext context) {
    return Provider.of<AnalyticsInterface>(context, listen: false);
  }
  Future<void> interaction(String named) {
    return send(AnalyticsEvent.interaction(named));
  }
  Future<void> impression(String named) {
    return send(AnalyticsEvent.impression(named));
  }
  Future<void> send(AnalyticsEvent event);
  Future<void> screenView(String name);
  NavigatorObserver get navigationObserver;
}