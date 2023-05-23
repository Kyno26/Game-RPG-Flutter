import 'package:game_rpg/component/global-variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

//create user data on Init Game
Future<void> createConfigData() async {
  var dataVersion = GlobalVariable.currentDataVersion;

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final SharedPreferences userPrefs = await prefs;

  userPrefs.setBool('profile_exist', true);
  userPrefs.setInt('version', dataVersion);

  userPrefs.setBool('stage1_unlocked', true);
  userPrefs.setBool('stage2_unlocked', false);
  userPrefs.setBool('stage3_unlocked', false);
  userPrefs.setBool('stage4_unlocked', false);
}

Future<void> saveStageProgress(
  bool isStage2Unlocked,
  bool isStage3Unlocked,
  bool isStage4Unlocked,
) async {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final SharedPreferences userPrefs = await prefs;

  userPrefs.setBool('stage1_unlocked', true);
  userPrefs.setBool('stage2_unlocked', isStage2Unlocked);
  userPrefs.setBool('stage3_unlocked', isStage3Unlocked);
  userPrefs.setBool('stage4_unlocked', isStage4Unlocked);
}

//check if user data exist
Future<bool> checkUserDataExist() async {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final SharedPreferences userPrefs = await prefs;

  return userPrefs.containsKey('profile_exist');
}
