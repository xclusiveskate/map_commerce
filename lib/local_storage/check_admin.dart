import 'package:shared_preferences/shared_preferences.dart';

bool? isAdmin = false;

class SaveToLocal {
  static Future<void> setBool() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('isAdmin', false);
  }

  static getBool() async {
    final pref = await SharedPreferences.getInstance();
    isAdmin = pref.getBool('isAdmin') ?? false;
    return isAdmin;
  }
}
