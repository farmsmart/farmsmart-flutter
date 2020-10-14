import 'package:flutter/widgets.dart';

class AnalyticsEventTypes {
  static const impression = 'impression';
  static const interaction = 'interaction';
  static const effect = 'effect';
}

class _Constants {
  static const typeField = 'type';
  static const contextField = 'context';
}

class AnalyticsEvent {
  final String name;
  final Map<String, dynamic> parameters;

  AnalyticsEvent(this.name, {this.parameters});

  factory AnalyticsEvent.impression(String name, {String context}) {
    Map<String, dynamic> base = {
      _Constants.typeField: AnalyticsEventTypes.impression
    };
    if (context != null) {
      base.addAll({_Constants.contextField: context});
    }
    return AnalyticsEvent(name, parameters: base);
  }

  factory AnalyticsEvent.interaction(String name, {String context}) {
    Map<String, dynamic> base = {
      _Constants.typeField: AnalyticsEventTypes.interaction
    };
    if (context != null) {
      base.addAll({_Constants.contextField: context});
    }
    return AnalyticsEvent(name, parameters: base);
  }

  factory AnalyticsEvent.effect(String name,
      {Map<String, dynamic> parameters}) {
    Map<String, dynamic> base = {
      _Constants.typeField: AnalyticsEventTypes.interaction
    };
    if (parameters != null) {
      base.addAll(parameters);
    }
    return AnalyticsEvent(name, parameters: base);
  }
}

abstract class AnalyticsInterface {

  static AnalyticsInterface _imp;

  static registerImplementation(AnalyticsInterface imp) {
    _imp = imp;
  }

  static AnalyticsInterface implementation() {
    return _imp;
  }

  Future<void> interaction(String named, {String context}) {
    return send(AnalyticsEvent.interaction(named, context:context));
  }

  Future<void> impression(String named, {String context}) {
    return send(AnalyticsEvent.impression(named, context: context));
  }

  Future<void> effect(String named, {Map<String, dynamic> parameters}) {
    return send(AnalyticsEvent.effect(named, parameters: parameters));
  }

  Future<void> send(AnalyticsEvent event);
  Future<void> userProperty(String name, String value);
  NavigatorObserver get navigationObserver;
}
