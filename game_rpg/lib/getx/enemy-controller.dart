// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/getx/audio-controller.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/item-controller.dart';
import 'package:game_rpg/getx/question-controller.dart';
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

  RxInt enemyID = 0.obs;

  RxString enemyPassive = ''.obs;
  List enemyPassiveList = [].obs;

  RxString enemyDefendAct = ''.obs;

  RxBool camouflageOn = false.obs;
  RxBool poisonOn = false.obs;
  RxBool gasOn = false.obs;
  RxBool burnOn = false.obs;

  RxInt maxPoisonDuration = 3.obs;
  RxInt curPoisonDuration = 0.obs;
  RxInt maxBurnDuration = 3.obs;
  RxInt curBurnDuration = 0.obs;
  RxInt maxGasDuration = 2.obs;
  RxInt curGasDuration = 0.obs;

  enemySelectorController({required int stage}){
    print('stage id: $stage');
    //kelipatan 5 = BOSS Fight
    switch (stage) {
      case 1:
        enemyID.value = 1;
        break;
      case 2:
        enemyID.value = 1;
        break;
      case 3:
        enemyID.value = 1;
        break;
      case 4:
        enemyID.value = 2;
        break;
      case 5:
        enemyID.value = 3;
        break;
      case 6:
        enemyID.value = 4;
        break;
      case 7:
        enemyID.value = 4;
        break;
      case 8:
        enemyID.value = 3;
        break;
      case 9:
        enemyID.value = 2;
        break;
      case 10:
        enemyID.value = 5;
        break;
      case 11:
        enemyID.value = 6;
        break;
      case 12:
        enemyID.value = 1;
        break;
      case 13:
        enemyID.value = 6;
        break;
      case 14:
        enemyID.value = 3;
        break;
      case 15:
        enemyID.value = 5;
        break;
      case 16:
        enemyID.value = 2;
        break;
      case 17:
        enemyID.value = 6;
        break;
      case 18:
        enemyID.value = 7;
        break;
      case 19:
        enemyID.value = 6;
        break;
      case 20:
        enemyID.value = 8;
        break;
      default:
        debugPrint('Error: Selecting Enemy');
        break;
    }
  }

  checkDebuff() {
    if(poisonOn.value){
      CharacterController.to.playerHealth.value = CharacterController.to.playerHealth.value - 5;
      curPoisonDuration++;
      if(curPoisonDuration.value == maxPoisonDuration.value){
        CharacterController.to.playerDef.value = CharacterController.to.playerDef.value + 3;
        poisonOn.value = false;
      }
    }
    if(gasOn.value){
      curGasDuration++;
      if(curGasDuration.value == maxGasDuration.value){
        gasOn.value = false;
      }
    }
    if(burnOn.value){
      CharacterController.to.playerHealth.value = CharacterController.to.playerHealth.value - 5;
      curBurnDuration++;
      if(curBurnDuration.value == maxBurnDuration.value){
        burnOn.value = false;
      }
    }
  }

  enemySpawner() async {
    var enemyId = enemySelectorController(stage: BattleFieldController.to.storyRound.value);
    print('Enemy id: $enemyId');
    print('Enemy ID: ${enemyID.value}');
    BattleFieldController.to.selectedEnemy = await DBManager.db.getEnemyByID(id: enemyID.value, tableName: 'enemy_lvl1').then((res) {
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
      // if(enemyPassive.value != ''){
      //   enemyPassiveList = json.decode(enemyPassive.value).cast<String>().toList();
      // }
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
      if(!ItemController.to.freezeActive.value){
        switch (actionSelected) {
          case 'attack':
            var attRes = await BattleFieldController.to.dodgeChance(spd: CharacterController.to.playerSpd.value, acc: enemyAcc.value, defender: CharacterController.to.playerName.value, attacker: 'enemy');
            if(attRes == 'HIT'){
              BattleFieldController.to.countDmgReceived(atk: enemyAtk.value, def: CharacterController.to.playerDef.value, hp: CharacterController.to.playerHealth, maxHp: CharacterController.to.playerMaxHealth.value, critRate: enemyCrit.value, attacker: enemyName.value, defender: CharacterController.to.playerName.value, attackerHp: enemyHealth);
            }
            break;
          case 'defend':
            BattleFieldController.to.addBuff(buff: enemyDefendAct.value, receiver: 'enemy');
            BattleFieldController.to.addBattleLog(message: 'bertahan', type: 'DEFEND', defender: enemyName.value);
            break;
          case 'camouflage':
            //code
            camouflageOn.value = true;
            BattleFieldController.to.addBattleLog(message: '${enemyName.value} menggunakan kamuflase', type: 'FREE');
            break;
          case 'poison':
            //code
            poisonOn.value = true;
            curPoisonDuration.value = 0;
            if(!poisonOn.value){
              CharacterController.to.playerDef.value = CharacterController.to.playerDef.value - 3;
            }
            BattleFieldController.to.addBattleLog(message: '${enemyName.value} meracuni ${CharacterController.to.playerName.value}', type: 'FREE');
            BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} akan menerima damage selama 3 ronde dan pertahanan menurun dari efek status negatif', type: 'FREE');
            break;
          case 'gas':
            //code
            gasOn.value = true;
            curGasDuration.value = 0;
            BattleFieldController.to.addBattleLog(message: '${enemyName.value} menyemprotkan gas bau kepada ${CharacterController.to.playerName.value}', type: 'FREE');
            BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} tidak dapat menyerang selama 2 giliran akibat dari status negatif', type: 'FREE');
            break;
          case 'double attack':
            //code
            BattleFieldController.to.addBattleLog(message: '${enemyName.value} menggunakan serangan ganda', type: 'FREE');
            var attRes = await BattleFieldController.to.dodgeChance(spd: CharacterController.to.playerSpd.value, acc: enemyAcc.value, defender: CharacterController.to.playerName.value, attacker: 'enemy');
            if(attRes == 'HIT'){
              BattleFieldController.to.countDmgReceived(atk: enemyAtk.value, def: CharacterController.to.playerDef.value, hp: CharacterController.to.playerHealth, maxHp: CharacterController.to.playerMaxHealth.value, critRate: enemyCrit.value, attacker: enemyName.value, defender: CharacterController.to.playerName.value, attackerHp: enemyHealth);
              BattleFieldController.to.countDmgReceived(atk: enemyAtk.value, def: CharacterController.to.playerDef.value, hp: CharacterController.to.playerHealth, maxHp: CharacterController.to.playerMaxHealth.value, critRate: enemyCrit.value, attacker: enemyName.value, defender: CharacterController.to.playerName.value, attackerHp: enemyHealth);
            }else{
              BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} berhasil menghindari serangan ganda', type: 'FREE');
            }
            break;
          case 'suck':
            //code
            CharacterController.to.playerHealth.value = CharacterController.to.playerHealth.value - 20;
            enemyHealth.value = enemyHealth.value + 20;
            if(enemyHealth.value > enemyMaxHealth.value){
              enemyHealth.value = enemyMaxHealth.value;
            }
            BattleFieldController.to.addBattleLog(message: '${enemyName.value} menghisap nyawa ${CharacterController.to.playerName.value} dan memulihkan HP sebanyak 20 poin', type: 'FREE');
            break;
          case 'burn':
            //code
            CharacterController.to.playerHealth.value = CharacterController.to.playerHealth.value - 15;
            burnOn.value = true;
            curBurnDuration.value = 0;
            BattleFieldController.to.addBattleLog(message: '${enemyName.value} menyerang ${CharacterController.to.playerName.value} menggunakan api dan menerima serangan sebesar 15 poin', type: 'FREE');
            BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} akan menerima kerusakan selama 3 ronde dari efek status negatif', type: 'FREE');
            break;
          default:
            var attRes = await BattleFieldController.to.dodgeChance(spd: CharacterController.to.playerSpd.value, acc: enemyAcc.value, defender: CharacterController.to.playerName.value, attacker: 'enemy');
            if(attRes == 'HIT'){
              BattleFieldController.to.countDmgReceived(atk: enemyAtk.value, def: CharacterController.to.playerDef.value, hp: CharacterController.to.playerHealth, maxHp: CharacterController.to.playerMaxHealth.value, critRate: enemyCrit.value, attacker: enemyName.value, defender: CharacterController.to.playerName.value, attackerHp: enemyHealth);
            }
            break;
        }
      }else{
        BattleFieldController.to.addBattleLog(message: 'tidak dapat bergerak karena membeku.', type: 'DEFEND', defender: enemyName.value);
      }
      
      if(ItemController.to.burnActive.value){
        enemyHealth.value = enemyHealth.value - 5;
        BattleFieldController.to.addBattleLog(message: 'menerima kerusakan sebesar 5 dari efek terbakar.', type: 'DEFEND', defender: enemyName.value);
      }
      
      BattleFieldController.to.removeEnemyBuffEffect();
      BattleFieldController.to.enemyAction.value = '';
      debugPrint('===== END OF ENEMY PHASE =====');

      if(ItemController.to.currentSmokeDuration.value != ItemController.to.smokeMaxDuration.value){
        ItemController.to.currentSmokeDuration.value++;
      }else{
        ItemController.to.smokeActive.value = false;
      }

      if(ItemController.to.curFreezeDur.value != ItemController.to.maxFreezeDur.value){
        ItemController.to.curFreezeDur.value++;
      }else{
        ItemController.to.freezeActive.value = false;
      }

      if(ItemController.to.curBurnDur.value != ItemController.to.maxBurnDur.value){
        ItemController.to.curBurnDur.value++;
      }else{
        ItemController.to.burnActive.value = false;
      }

      QuestionController.to.clearQuestionValue();

      Timer(const Duration(seconds: 2), (){
        BattleFieldController.to.turnIcon.value = 'assets/icons/waiting-icon.svg';
        BattleFieldController.to.turn.value = 'waiting';
        BattleFieldController.to.battleTurnSystem();
        BattleFieldController.to.startBattle.value = false;
      });
  }
}