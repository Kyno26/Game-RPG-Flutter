// ignore_for_file: file_names, unnecessary_cast

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/enemy-controller.dart';
import 'package:game_rpg/getx/item-controller.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:game_rpg/model/item.dart';
import 'package:get/get.dart';

class CharacterController extends GetxController{
  static CharacterController get to => Get.find<CharacterController>();

  //========== Character Data ============
  RxBool selected = false.obs;
  RxInt selectedCharacterId = 0.obs;
  RxString selectedCharacterName = ''.obs;
  RxString selectedCharacterJob = ''.obs;
  RxInt selectedCharacterHP = 0.obs;
  RxInt selectedCharacterAttack = 0.obs;
  RxInt selectedCharacterDefense = 0.obs;
  RxInt selectedCharacterSpeed = 0.obs;
  RxInt selectedCharacterAccuracy = 0.obs;
  RxInt selectedCharacterCritRate = 0.obs;
  RxString selectedCharacterImage = ''.obs;
  RxString selectedCharacterPotraitImage = ''.obs;
  //=======================================


  //======= Character Unlock List =========
  RxInt yingStar = 1.obs;
  RxInt kayaStar = 0.obs;
  RxInt nimiStar = 0.obs;
  RxInt chloeStar = 0.obs;
  RxInt sakuyaStar = 0.obs;

  RxBool yingUnlocked = true.obs;
  RxBool kayaUnlocked = true.obs;
  RxBool nimiUnlocked = true.obs;
  RxBool chloeUnlocked = true.obs;
  RxBool sakuyaUnlocked = true.obs;
  //=======================================

  //======= CHARACTER BATTLE STATS ========
  RxString playerCharacterImage = ''.obs;
  RxString playerName = ''.obs;
  RxInt playerMaxHealth = 0.obs;
  RxInt playerHealth = 0.obs;
  RxInt playerAtk = 0.obs;
  RxInt playerDef = 0.obs;
  RxInt playerSpd = 0.obs;
  RxInt playerAcc = 0.obs;
  RxInt playerCrit = 0.obs;

  RxInt maxBagCapacity = 10.obs;

  // List itemList = <Item>[].obs;
  List<Item> itemList = [];
  RxString selectedItemID = ''.obs;
  //=======================================

  resetValue(){
    selected.value = false;
    selectedCharacterId.value = 0;
    selectedCharacterName.value = '';
    selectedCharacterJob.value = '';
    selectedCharacterHP.value = 0;
    selectedCharacterAttack.value = 0;
    selectedCharacterDefense.value = 0;
    selectedCharacterImage.value = '';
    selectedCharacterPotraitImage.value = '';
  }

  checkCharacterDetail({required int charactedID}) {
    selectedCharacterId.value = charactedID;
  }

  characterSelected({
    required int characterId, 
    required String characterName,
    required int characterHP,
    required int characterAtk,
    required int characterDef,
    required int characterSpd,
    required int characterAcc,
    required int characterCrit,
    required String characterImage,
    required String characterPotrait,
  }) {
    selected.value = true;
    selectedCharacterId.value = characterId;
    selectedCharacterName.value = characterName;
    selectedCharacterHP.value = characterHP;
    selectedCharacterAttack.value = characterAtk;
    selectedCharacterDefense.value = characterDef;
    selectedCharacterSpeed.value = characterSpd;
    selectedCharacterAccuracy.value = characterAcc;
    selectedCharacterCritRate.value = characterCrit;
    selectedCharacterImage.value = characterImage;
    selectedCharacterPotraitImage.value = characterPotrait;
  }

  selectCharacter({required String name, required String image, required int hp, required int atk, required int def, required int spd, required int acc, required int crit,}) {
    playerName.value = name;
    playerCharacterImage.value = image;
    playerMaxHealth.value = hp;
    playerHealth.value = hp;
    playerAtk.value = atk;
    playerDef.value = def;
    playerSpd.value = spd;
    playerAcc.value = acc;
    playerCrit.value = crit;
  }

  checkCharacterUnlockStatus<bool> ({required int characterId}) {
    switch(characterId) {
      case 1:
        return yingUnlocked.value;
      case 2:
        return kayaUnlocked.value;
      case 3:
        return nimiUnlocked.value;
      case 4:
        return chloeUnlocked.value;
      case 5:
        return sakuyaUnlocked.value;
    }
  }

  checkCharacterStar ({required int characterId}) {
    switch(characterId) {
      case 1:
        return yingStar.value;
      case 2:
        return kayaStar.value;
      case 3:
        return nimiStar.value;
      case 4:
        return chloeStar.value;
      case 5:
        return sakuyaStar.value;
    }
  }


  playerPhase({required String actionSelected, String? buffName}) async {
    if(BattleFieldController.to.turn.value == 'player'){
      if (kDebugMode) {
        debugPrint('Player Turn: ${BattleFieldController.to.playerTurn.value}');
        debugPrint('===== PLAYER PHASE =====');
      }
      switch (actionSelected) {
        case 'Attack':
          var attRes = await BattleFieldController.to.dodgeChance(spd: EnemyController.to.enemySpd.value, acc: playerAcc.value, defender: EnemyController.to.enemyName.value, attacker: 'player', defenderPassiveSkill: EnemyController.to.enemyPassiveList);
          if(attRes == 'HIT'){
            BattleFieldController.to.countDmgReceived(atk: CharacterController.to.playerAtk.value, def: EnemyController.to.enemyDef.value, hp: EnemyController.to.enemyHealth, maxHp: EnemyController.to.enemyMaxHealth.value, critRate: playerCrit.value, attacker: playerName.value, defender: EnemyController.to.enemyName.value, attackerHp: playerHealth);
          }
          break;
        case 'Defend':
          BattleFieldController.to.addBuff(buff: buffName!, receiver: 'player');
          break;
        case 'Use Item':
          ItemController.to.useItem(itemID: selectedItemID.value);
          break;
        default:
      }
      BattleFieldController.to.removePlayerBuffEffect();
      BattleFieldController.to.turn.value = 'enemy';
      debugPrint('===== END OF PLAYER PHASE =====');
      Timer(const Duration(seconds: 2), (){
        QuestionController.to.answerCorrect.value = false;
        BattleFieldController.to.battleTurnSystem();
      });
    }
  }
}