
class Utils {
  static bool listIsNotNullOrEmpty(List list) => list != null && list.length > 0;
  static String capitalize(String string) => string[0].toUpperCase() + string.substring(1).toLowerCase();
}