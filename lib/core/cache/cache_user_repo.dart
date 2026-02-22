import 'package:shared_preferences/shared_preferences.dart';

class CacheUserRepo {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> login(bool value) async {
    await sharedPreferences.setBool('isLogin', value);
  }

  static Future<void> logout() async {
    await sharedPreferences.setBool("isLogin", false);
  }

  static Future<bool> isLogin() async {
    return sharedPreferences.getBool('isLogin') ?? false;
  }
}
