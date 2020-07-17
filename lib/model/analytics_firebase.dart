import 'package:farmsmart_flutter/model/analytics_interface.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/widgets.dart';

class AnalyticsFirebaseImp extends AnalyticsInterface {

  final FirebaseAnalytics analytics;

  static String acceptableString(String string) {
    if(string!= null){
       return string.replaceAll(RegExp(r"\s+\b|\b\s|\s|\b"), "");
    }
   return null;
  }

  AnalyticsFirebaseImp(this.analytics);



  Future<void> send(AnalyticsEvent event){
    final acceptableParameters = event.parameters.map<String, String>(
                (key, value) => MapEntry(acceptableString(key), value));
    final acceptableName = acceptableString(event.name);
    return analytics.logEvent(name: acceptableName, parameters: acceptableParameters);
  }

  Future<void> userProperty(String name, String value){
    final acceptableName = acceptableString(name);
    return analytics.setUserProperty(name: acceptableName, value: value);
  }

  NavigatorObserver get navigationObserver  => FirebaseAnalyticsObserver(analytics: analytics);

}