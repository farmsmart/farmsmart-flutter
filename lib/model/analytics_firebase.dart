import 'package:farmsmart_flutter/model/analytics_interface.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/widgets.dart';

class AnalyticsFirebase extends AnalyticsInterface {

  final FirebaseAnalytics analytics;

  AnalyticsFirebase(this.analytics);

  Future<void> send(AnalyticsEvent event){
    return analytics.logEvent(name: event.name, parameters: event.parameters);
  }
  
  Future<void> screenView(String name){
    return analytics.setCurrentScreen(screenName: name);
  }

  NavigatorObserver get navigationObserver  => FirebaseAnalyticsObserver(analytics: analytics);

}