// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:get/get.dart';

class EnemyController extends GetxController{
  static EnemyController get to => Get.find<EnemyController>();

  RxString selectedEnemy = ''.obs;
  RxString enemyImage = ''.obs;
  RxString enemyName = ''.obs;
  RxInt enemyMaxHealth = 0.obs;
  RxInt enemyHealth = 0.obs;
  RxInt enemyAtk = 0.obs;
  RxInt enemyDef = 0.obs;
  RxInt enemySpd = 0.obs;
  RxInt enemyAcc = 0.obs;
  RxInt enemyCrit = 0.obs;
  RxString rawActionList = ''.obs;

  RxString enemyPassive = ''.obs;
  List enemyPassiveList = [].obs;

  RxString enemyDefendAct = ''.obs;

  enemySelectorController({required int stage}){
    if(stage < 5){
      //enemy ID: Bee
      return 1;
    }else{
      switch (stage) {
        case 5:
          //enemy ID: coyote
          return 2;
        default:
          debugPrint('Error: enemy selection!');
          break;
      }
    }
  }

  enemySpawner() async {
    var enemyId = enemySelectorController(stage: BattleFieldController.to.storyRound.value);
    BattleFieldController.to.selectedEnemy = await DBManager.db.getEnemyByID(id: enemyId, tableName: 'enemy_lvl1').then((res) {
      enemyHealth.value = res!.hp;
      enemyName.value = res.name;
      enemyMaxHealth.value = res.hp;
      enemyAtk.value = res.atk;
      enemyDef.value = res.def;
      enemySpd.value = res.spd;
      enemyAcc.value = res.acc;
      enemyCrit.value = res.crit;
      enemyImage.value = res.image;
      enemyDefendAct.value = res.defAction;
      rawActionList.value = res.actionList;
      enemyPassive.value = res.passiveList ?? '';
      if(enemyPassive.value != ''){
        enemyPassiveList = json.decode(enemyPassive.value).cast<String>().toList();
      }
      BattleFieldController.to.turn.value = 'waiting';
      BattleFieldController.to.turnIcon.value = 'assets/icons/waiting-icon.svg';
      BattleFieldController.to.questionPhase.value = false;
      BattleFieldController.to.startBattle.value = false;
      return null;
    });
  }

  enemyActionRandomizer(){
    List actionList = json.decode(rawActionList.value).cast<String>().toList();
    var actionRes = Random().nextInt(actionList.length);
    print(actionList[actionRes]);
    return actionList[actionRes];
  }

  enemyPhase({required String actionSelected}) async {
      if (kDebugMode) {
        debugPrint('===== ENEMY PHASE =====');
      }
      print(actionSelected);
      switch (actionSelected) {
        case 'attack':
          var attRes = await BattleFieldController.to.dodgeChance(spd: CharacterController.to.playerSpd.value, acc: enemyAcc.value, defender: CharacterController.to.playerName.value, attacker: 'enemy');
          if(attRes == 'HIT'){
            BattleFieldController.to.countDmgReceived(atk: enemyAtk.value, def: CharacterController.to.playerDef.value, hp: CharacterController.to.playerHealth, maxHp: CharacterController.to.playerMaxHealth.value, critRate: enemyCrit.value, attacker: enemyName.value, defender: CharacterController.to.playerName.value, attackerHp: enemyHealth);
          }
          
          break;
        case 'defend':
          BattleFieldController.to.addBuff(buff: enemyDefendAct.value, receiver: 'enemy');
          
          break;
        default:
      }
      BattleFieldController.to.removeEnemyBuffEffect();
      BattleFieldController.to.enemyAction.value = '';
      debugPrint('===== END OF ENEMY PHASE =====');
      Timer(const Duration(seconds: 2), (){
        BattleFieldController.to.turnIcon.value = 'assets/icons/waiting-icon.svg';
        BattleFieldController.to.turn.value = 'waiting';
        BattleFieldController.to.battleTurnSystem();
        BattleFieldController.to.startBattle.value = false;
      });
  }
}