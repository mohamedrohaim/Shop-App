
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences? sharedPreferences;
  static init ()async
  {
    sharedPreferences=await SharedPreferences.getInstance();
  }
 static Future<bool> saveData({ String? key, dynamic value})async
  {
    if(value is String) {
      return await sharedPreferences!.setString(key!, value);
    }
    if(value is int) {
      return await sharedPreferences!.setInt(key!, value);
    }
    if(value is bool) {
      return await sharedPreferences!.setBool(key!, value);
    }

    return await sharedPreferences!.setDouble(key!, value);

  }
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }
  static dynamic DeleteData({
    required String key,
  }){
    return sharedPreferences!.remove(key);
  }

  static dynamic ClearData({
    required String key,
  }){
    return sharedPreferences!.clear();
  }


}