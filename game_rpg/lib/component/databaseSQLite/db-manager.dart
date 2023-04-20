// ignore_for_file: file_names

import 'dart:io';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:game_rpg/component/global-variable.dart';
import 'package:game_rpg/model/basic_question.dart';
import 'package:game_rpg/model/buff.dart';
import 'package:game_rpg/model/character.dart';
import 'package:game_rpg/model/enemy.dart';
import 'package:game_rpg/model/item.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  DBManager._();

  static final DBManager db = DBManager._();
  Database? _database;

  // Future<Database> get database async => _database ??= await createDatabaseInstance();

  int currentVersion = GlobalVariable.databaseVersion;
  int newDataVersion = GlobalVariable.newDatabaseVersion;

  Future<void> createDatabaseInstance() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "biosDatabase.db");
    var dbExist = await databaseExists(path);
    if(!dbExist) {
      if (kDebugMode) {
        debugPrint('===== Loading Database from asset =====');
      }
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){
        if (kDebugMode) {
          debugPrint(_.toString());
        }
      }

      //load database
      ByteData data = await rootBundle.load(join('assets/data', 'biosDatabase.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }else{
      if (kDebugMode) {
        debugPrint('===== Updating Database from asset =====');
      }
      await deleteDatabase(path);
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){
        if (kDebugMode) {
          debugPrint(_.toString());
        }
      }

      //load database
      ByteData data = await rootBundle.load(join('assets/data', 'biosDatabase.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }
    openDB();
  }

  Future<Database> openDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "biosDatabase.db");
    // await createDatabaseInstance();
    Database db = await openDatabase(path, readOnly: true);
    return db;
  }

  Future<List<Character>> getAllCharacter() async {
    final Database db = await openDB();
    // final db = openDB();
    var response = await db.query("playable_character");
    List<Character> list = response.map((c) => Character.fromMap(c)).toList();
    return list;
  }

  Future<List<Enemy>> getAllEnemyLvl1Data() async {
    final Database db = await openDB();
    var response = await db.query("enemy_lvl1");
    List<Enemy> list = response.map((c) => Enemy.fromMap(c)).toList();
    return list;
  }

  Future<int> getCount({required String tableName}) async {
    final Database db = await openDB();
    var x = await db.rawQuery('SELECT COUNT (*) from $tableName');
    int count = Sqflite.firstIntValue(x)!;
    return count;
  }

  Future<Enemy?> getEnemyByID({required int id, required String tableName}) async {
    final Database db = await openDB();
    var response = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    if (kDebugMode) {
      print('===== ENEMY DETAIL =====');
      debugPrint('$id');
      debugPrint('$response');
      debugPrint('========================');
    }
    return response.isNotEmpty ? Enemy.fromMap(response.first) : null;
  }

  Future<Buff?> getBuff({required String buffName}) async {
    final Database db = await openDB();
    var result = await db.rawQuery('SELECT * FROM buff_list WHERE buff_name=?', [buffName]);
    if (kDebugMode) {
      debugPrint('$result');
    }
    return Buff.fromMap(result.first);
  }

  Future<BasicQuestion> getQuestion({required int idQuestion}) async {
    final Database db = await openDB();
    var result = await db.rawQuery('SELECT * FROM question WHERE id=?', [idQuestion]);
    if (kDebugMode) {
      debugPrint('$result');
    }
    return BasicQuestion.fromMap(result.first);
  }

  Future<Item> getItem({required int itemID}) async {
    final Database db = await openDB();
    var result = await db.rawQuery('SELECT * FROM item_list WHERE id=?', [itemID]);
    if (kDebugMode) {
      debugPrint('$result');
    }

    return Item.fromMap(result.first);
  }

}