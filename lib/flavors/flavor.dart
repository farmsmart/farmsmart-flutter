import 'package:shared_preferences/shared_preferences.dart';

const FLAME_LINK_ENVIRONMENT = 'fl.env';


void writeEnvironment(environment) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(FLAME_LINK_ENVIRONMENT, environment);
}

Future<String> getEnvironment() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(FLAME_LINK_ENVIRONMENT);
}