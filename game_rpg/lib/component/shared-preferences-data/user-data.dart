import 'package:game_rpg/component/global-variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

//create user data on Init Game
Future<void> createConfigData() async {
  var dataVersion = GlobalVariable.currentDataVersion;

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final SharedPreferences userPrefs = await prefs;

  userPrefs.setBool('profile_exist', true);
  userPrefs.setInt('version', dataVersion);
}

//check if user data exist
Future<bool> checkUserDataExist() async {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final SharedPreferences userPrefs = await prefs;

  return userPrefs.containsKey('profile_exist');
}
