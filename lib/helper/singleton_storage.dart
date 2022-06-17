import 'package:shared_preferences/shared_preferences.dart';

class SingletonStorage {
  static SingletonStorage? _instance;
  static SharedPreferences? _preferences;
  static String TAG_URL ='url';
  static String TAG_FTP ='ftp';

  static Future<SingletonStorage?> getInstance() async {
    _instance ??= SingletonStorage();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  static void setURL(String url) {
    _preferences!.setString('url', url);
  }
  static Future<String?> getURL() async {
    return _preferences!.getString('url');
  }
  static void setConfigName(String configName) {
    _preferences!.setString('ConfigName', configName);
  }
  static Future<String?> getConfigName() async {
    return _preferences!.getString('ConfigName');
  }
  static void setDescriptionName(String descriptionName) {
    _preferences!.setString('DescriptionName', descriptionName);
  }
  static Future<String?> getDescriptionName() async {
    return _preferences!.getString('DescriptionName');
  }

  static Future<bool> clearData()async{
   return await _preferences!.clear();
  }
}