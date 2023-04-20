import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

//get data String
Future<String> getStringLocalData(String param) async {
  String data = '';
  try {
    Future<SharedPreferences> sharePref = SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharePref;
    data = prefs.getString(param)!;
  } catch (e) {
    log('Error: $e at $param');
  }

  return data;
}

//get data int
Future<int?> getIntLocalData(String param) async {
  int? data;
  try {
    Future<SharedPreferences> sharePref = SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharePref;
    data = prefs.getInt(param)!;
  } catch (e) {
    log('Error: $e at $param');
  }

  return data;
}

//get data Boolean
Future<bool?> getBoolLocalData(String param) async {
  bool? data;
  try {
    Future<SharedPreferences> sharePref = SharedPreferences.getInstance();
    final SharedPreferences prefs = await sharePref;
    data = prefs.getBool(param)!;
  } catch (e) {
    log('Error: $e at $param');
  }

  return data;
}