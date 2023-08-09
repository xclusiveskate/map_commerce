import 'package:shared_preferences/shared_preferences.dart';

class SaveToLocal {
  static Future<void> setBool() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isAdmin', false);
  }

  static getBool() async {
    final pref = await SharedPreferences.getInstance();
    final theStatus = pref.getBool('isAdmin') ?? false;
    return theStatus;
  }
}
