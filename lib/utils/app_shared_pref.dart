import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  getToken() async {
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString('token') ?? "");
    return token;*/
    return "";
  }
}
