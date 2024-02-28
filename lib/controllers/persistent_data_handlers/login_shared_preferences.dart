import 'package:shared_preferences/shared_preferences.dart';

class LoginSharedPreferences {
  ///----Login access info
  static get accessToken async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //return "=ITMxMjMwEzM3ATMzADMxMTN0IDO0IDO0IDNwEzMxATMzQjMxMDO0IjM1IDM1IDNyEzM0UjMzUjM4UjM2UjM4QjM4UjM2UjM4QjMyMjM1UjM4QjM1QjM1UjM4QjM1QjMxUjMwUjM4QjMwUjM";

    return prefs.getString('access_token') ?? "";
  }

  static setAccessToken(String? newAccessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', newAccessToken ?? "");
    print("set accessToken : ${await accessToken}");
  }

  ///----Login credentials
  static get username async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('username') ?? "";
  }

  static setUsername(String? newDeviceId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newDeviceId ?? "");
    //print("set ${await deviceId}");
  }

  static get password async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password') ?? "";
  }

  static setPassword(String? newVName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', newVName ?? "");
    //print("set ${await vName}");
  }

  ///functions
  static Future saveAccessInformation(
      String? accessToken) async {
    await setAccessToken(accessToken);
  }

  static Future saveLoginCredentials(String? username, String? password) async {
    await setUsername(username);
    await setPassword(password);
  }
}
