import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  static String userIdKey ="userIdKey";
  static String userNameKey="UserNameKey";
  static String userEmailKey="userEmailKey";

  Future <bool> saveUserId(String getUserId) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }
  Future <bool> saveUserName(String getUserName) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }
  Future <bool> saveUserEmail(String getUserEmail) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  Future<String?> getUserId() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future <String?> getUserName() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future <String?> getUserEmail() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

}