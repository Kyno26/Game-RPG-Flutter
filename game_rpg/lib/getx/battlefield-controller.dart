// ignore_for_file: file_names
import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/component/shared-preferences-data/user-data.dart';
import 'package:game_rpg/getx/audio-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/enemy-controller.dart';
import 'package:game_rpg/getx/item-controller.dart';
import 'package:game_rpg/getx/profile-controller.dart';
import 'package:game_rpg/getx/special-dialog-controller.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:game_rpg/getx/shop-controller.dart';
import 'package:game_rpg/model/buff.dart';
import 'package:game_rpg/model/enemy.dart';
import 'package:game_rpg/model/item.dart';
import 'package:get/get.dart';

class BattleFieldController extends GetxController{
  static BattleFieldController get to => Get.find<BattleFieldController>();

  RxString imageBG = ''.obs;
  RxInt enemyDefeated = 0.obs;
  RxInt storyRound = 1.obs;
  RxInt scorePerQuestion = 0.obs;
  RxString stageText = ''.obs;

  RxInt playerTurn = 1.obs;
  RxInt enemyTurn = 1.obs;
  RxString turn = ''.obs;
  RxString turnIcon = ''.obs;
  RxString enemyAction = ''.obs;

  RxBool questionPhase = false.obs;
  RxBool startBattle = false.obs;

  Future<List<Enemy>>? enemyLVL1List;
  Enemy? selectedEnemy;
  RxBool enemyActive = false.obs;

  RxString effectAnimation = ''.obs;
  RxBool showEnemyAnimation = false.obs;
  RxBool showPlayerAnimation = false.obs;

  RxBool gameFinished = false.obs;

  Buff? buffObtained;
  List battleLog = [].obs;

  Item? itemGet;
  List<Item> itemShowUp = [];

  List<Buff> playerAtkBuff = [];
  List<Buff> playerDefBuff = [];
  List<Buff> playerSpdBuff = [];
  List<Buff> playerAccBuff = [];

  List<Buff> enemyAtkBuff = [];
  List<Buff> enemyDefBuff = [];
  List<Buff> enemySpdBuff = [];
  List<Buff> enemyAccBuff = [];


  RxBool stage1Unlocked = true.obs;
  RxBool stage2Unlocked = true.obs;
  RxBool stage3Unlocked = false.obs;
  RxBool stage4Unlocked = false.obs;

  bgSelector() {
    if(storyRound.value <= 5){
      imageBG.value = 'assets/images/background/field-bg.png';
    }else if(storyRound.value > 5 && storyRound.value <= 10){
      imageBG.value = 'assets/images/background/forest-bg.jpg';
    }else{
      imageBG.value = 'assets/images/background/forest-bg-2.jpg';
    }
  }

  stageUnlock() {
    if(storyRound.value == 6){
      saveStageProgress(true, false, false);
      stage2Unlocked.value = true;
    }else if(storyRound.value == 11){
      saveStageProgress(true, true, false);
      stage3Unlocked.value = true;
    }else if(storyRound.value == 16){
      saveStageProgress(true, true, true);
      stage4Unlocked.value = true;
    }
  }

  chooseRandomBG() {
    int min = 1;
    int max = 2;

    var selectedBG = Random().nextInt(max - min + 1) + min;
    switch (selectedBG) {
      case 1:
        return imageBG.value = 'assets/images/background/field-bg.png';
      case 2:
        return imageBG.value = 'assets/images/background/field-bg.png';
      default:
        return imageBG.value = 'assets/images/background/field-bg.png';
    }
  }

  initializeSystem() {
    // enemyLvl1Generate();
    turn.value = 'waiting';
    turnIcon.value = 'assets/icons/waiting-icon.svg';
    questionPhase.value = false;
    startBattle.value = false;
    showEnemyAnimation.value = false;
    showPlayerAnimation.value = false;
    QuestionController.to.answerCorrect.value = false;
    effectAnimation.value = '';
    ProfileController.to.continueGameStatus.value = true;
    QuestionController.to.showAnswer.value = false;
    QuestionController.to.showAnimation.value = false;
    // giveUpgradePoint(round: storyRound.value);
    // QuestionController.to.currentScore.value = 0;
    // ShopController.to.coinGetBattle.value = 0;
    // storyRound.value = 1;
    // ItemController.to.generateItem();
    stageText.value = stageCountController(storyRound.value);
    scorePerQuestion.value = questionScoreController(storyRound.value);
  }

  resetBattlegroundData({required int stage}) {
    playerAtkBuff.clear();
    playerDefBuff.clear();
    playerAccBuff.clear();
    playerSpdBuff.clear();
    enemyAtkBuff.clear();
    enemyDefBuff.clear();
    enemyAccBuff.clear();
    enemySpdBuff.clear();
    itemShowUp.clear();
    gameFinished.value = false;
    QuestionController.to.clearQuestionValue();
    CharacterController.to.itemList.clear();
    CharacterController.to.selectedItemID.value = '';
    CharacterController.to.upgradePointOwned.value = 0;
    CharacterController.to.upgradePointAvailable.value = 0;
    EnemyController.to.burnOn.value = false;
    EnemyController.to.poisonOn.value = false;
    EnemyController.to.gasOn.value = false;
    EnemyController.to.camouflageOn.value = false;
    enemyDefeated.value = 0;
    playerTurn.value = 1;
    storyRound.value = stage;
    enemyActive.value = false;
    battleLog.clear();
    EnemyController.to.enemySpawner();
    QuestionController.to.currentScore.value = 0;
    ShopController.to.coinGetBattle.value = 0;
    ItemController.to.lifeNecklaceOn.value = false;
    ItemController.to.generateItem();
  }

  randomEnemyGenerator() async {
    int min = 1;
    int max = await DBManager.db.getCount(tableName: 'enemy_lvl1');
    
    var enemyID = Random().nextInt(max - min + 1) + min;
    selectedEnemy = await DBManager.db.getEnemyByID(id: enemyID, tableName: 'enemy_lvl1').then((res) {
      EnemyController.to.enemyHealth.value = res!.hp;
      EnemyController.to.enemyName.value = res.name;
      EnemyController.to.enemyMaxHealth.value = res.hp;
      EnemyController.to.enemyAtk.value = res.atk;
      EnemyController.to.enemyDef.value = res.def;
      EnemyController.to.enemySpd.value = res.spd;
      EnemyController.to.enemyAcc.value = res.acc;
      EnemyController.to.enemyCrit.value = res.crit;
      EnemyController.to.enemyImage.value = res.image;
      EnemyController.to.enemyDefendAct.value = res.defAction;
      EnemyController.to.rawActionList.value = res.actionList;
      turn.value = 'waiting';
      turnIcon.value = 'assets/icons/waiting-icon.svg';
      questionPhase.value = false;
      startBattle.value = false;
      return null;
    });
  }

  questionScoreController(int round) {
    if (round < 3) {
      //round 1-2
      return 2;
    } else if (round < 5){
      //round 3-4
      return 3;
    } else if (round == 5){
      //round 5
      return 5;
    } else if (round < 8){
      //round 6-7
      return 6;
    } else if (round < 10){
      //round 8-9
      return 7;
    } else if (round == 10){
      //round 10
      return 8;
    } else if (round < 15){
      //round 11-14
      return 9;
    } else if (round == 15){
      //round 15
      return 10;
    } else if (round < 19){
      //round 16-19
      return 10;
    }else {
      //round 19-20
      return 15;
    }
  }

  giveUpgradePoint({required int round}){
    if(storyRound.value == 6){
      CharacterController.to.upgradePointOwned.value = CharacterController.to.upgradePointOwned.value + 10;
      CharacterController.to.upgradePointAvailable.value = CharacterController.to.upgradePointAvailable.value + 10;
    }else if(storyRound.value == 11){
      CharacterController.to.upgradePointOwned.value = CharacterController.to.upgradePointOwned.value + 10;
      CharacterController.to.upgradePointAvailable.value = CharacterController.to.upgradePointAvailable.value + 10;
    }else if(storyRound.value == 16){
      CharacterController.to.upgradePointOwned.value = CharacterController.to.upgradePointOwned.value + 15;
      CharacterController.to.upgradePointAvailable.value = CharacterController.to.upgradePointAvailable.value + 15;
    }
  }

  stageCountController(int round) {
    if(storyRound.value > 0 && storyRound.value <= 5){
      return stageText.value = '1 - $round';
    }else if (round >= 6 && round <= 10){
      return stageText.value = '2 - ${round - 5}';
    }else if (round >= 11 && round <= 15){
      return stageText.value = '3 - ${round - 10}';
    }else if (round >= 16 && round <= 20){
      return stageText.value = '4 - ${round - 15}';
    }else {
      return stageText.value = 'Game Clear';
    }
  }

  startPlayerTurn() {
    turn.value = 'player';
    QuestionController.to.getQuestionFromDatabase();
    BattleFieldController.to.questionPhase.value = true;
  }

  battleTurnSystem() {
    if(CharacterController.to.playerHealth.value > 0){
      addBattleLog(message: 'current story stage ${storyRound.value}', type: 'FREE');
      if(EnemyController.to.enemyHealth.value > 0){
        if(turn.value == 'enemy'){
          // turnIcon.value = 'assets/icons/enemy-turn-icon.svg';
          enemyAction.value = EnemyController.to.enemyActionRandomizer();
          print(enemyAction.value);
          EnemyController.to.enemyPhase(actionSelected: enemyAction.value);
          enemyTurn.value++;
        }
      }else{
        if(storyRound.value == 20){
          gameFinished.value = true;
        }else{
        //Enemy Defeated
        addBattleLog(attacker: CharacterController.to.playerName.value, defender: EnemyController.to.enemyName.value, message: 'berhasil mengalahkan', type: 'DEFEAT');
        turn.value = 'waiting';
        turnIcon.value = 'assets/icons/waiting-icon.svg';
        // randomEnemyGenerator();
        EnemyController.to.enemySpawner();
        stageUnlock();
        bgSelector();
        ItemController.to.smokeActive.value = false;
        ItemController.to.freezeActive.value = false;
        ItemController.to.burnActive.value = false;
        giveUpgradePoint(round: storyRound.value);
        enemyActive.value = false;
        enemyDefeated.value++;
        playerTurn.value = 1;
        storyRound.value++;
        stageText.value = stageCountController(storyRound.value);
        scorePerQuestion.value = questionScoreController(storyRound.value);
        QuestionController.to.currentScore.value = QuestionController.to.currentScore.value + 20;
        ShopController.to.coinGetBattle.value = ShopController.to.coinGetBattle.value + 15;
        SpecialDialogController.to.showitemGetDialog();
        }
      }
    }else{
      //Player Defeated
      if(ItemController.to.lifeNecklaceOn.value){
        CharacterController.to.playerHealth.value = CharacterController.to.playerMaxHealth.value;
        ItemController.to.removeItemFromItemList(itemID: 9);
        ItemController.to.lifeNecklaceOn.value = false;
        addBattleLog(message: 'Item Jimat Penyelamat telah digunakan!', type: 'USE ITEM');
      }else{
        ProfileController.to.continueGameStatus.value = false;
        SpecialDialogController.to.showGameOverDialog();
      }
    }
  }

  countDmgReceived({required int atk, required int def, required RxInt hp, required int maxHp, required int critRate, required String attacker, required String defender, required RxInt attackerHp, List? defenderPassiveSkill}) {
    var noCritRate = 100 - critRate;
    List critChanceContainer = [];

    var tempDmg = def - atk;
    if(tempDmg >= 0){
      tempDmg = -1;
    }
    int dmg = tempDmg;
    
    for(var i = 0; i < critRate; i++){
      critChanceContainer.add('CRITICAL HIT');
    }

    for (var i = 0; i < noCritRate; i++) {
      critChanceContainer.add('NORMAL HIT');
    }

    effectAnimation.value = 'assets/images/lottie/hit-effect.json';

    var critResult = Random().nextInt(critChanceContainer.length);
    if (kDebugMode) {
      debugPrint(critChanceContainer[critResult] + '!!!');
    }

    if(critChanceContainer[critResult] == 'CRITICAL HIT'){
      if (kDebugMode) {
        debugPrint('normal dmg: $tempDmg');
      }
      effectAnimation.value = 'assets/images/lottie/critical-hit-effect.json';
      dmg  = tempDmg * 2;
    }
    
    hp.value = hp.value + dmg;
    
    if (kDebugMode) {
      debugPrint('MAX HP: $maxHp');
      debugPrint('CURRENT HP: ${hp.value}');
      debugPrint('DMG DEALT: $dmg');
    }
    var txtDmg = dmg * -1;
    if(hp.value <= 0){
      hp.value = 0;
    }

    debugPrint('Attacker: ${turn.value}');
    //Attack Animation
    if(turn.value == 'player'){
      showEnemyAnimation.value = true;
      if(critChanceContainer[critResult] == 'NORMAL HIT'){
        AudioController.to.playNormalAtkBGM();
      }else{
        AudioController.to.playCriticalAtkBGM();
      }
      Timer(const Duration(seconds: 1), (){
        showEnemyAnimation.value = false;
      });
    }else{
      showPlayerAnimation.value = true;
      CharacterController.to.playerHit.value = true;
      if(critChanceContainer[critResult] == 'NORMAL HIT'){
        AudioController.to.playNormalAtkBGM();
      }else{
        AudioController.to.playCriticalAtkBGM();
      }
      Timer(const Duration(milliseconds: 250), (){
        showPlayerAnimation.value = false;
        CharacterController.to.playerHit.value = false;
      });
    }

    addBattleLog(attacker: attacker, defender: defender, message: 'terkena serangan sebesar $txtDmg dari', type: 'ATK');
    
    return hp;
  }

  countItemDMG({required int dmgDealt}) {
    effectAnimation.value = 'assets/images/lottie/hit-effect.json';

    EnemyController.to.enemyHealth.value = EnemyController.to.enemyHealth.value - dmgDealt;
    if(EnemyController.to.enemyHealth.value < 0){
      EnemyController.to.enemyHealth.value = 0;
    }

    showEnemyAnimation.value = true;
    Timer(const Duration(seconds: 1), (){
      showEnemyAnimation.value = false;
    });
  }

  Future dodgeChance<String>({required int spd, required int acc, required String defender, required String attacker, List? defenderPassiveSkill}) async {

    List dodgeRate = [];
    var countRate = acc - spd;
    if (kDebugMode) {
      debugPrint('defender spd: $spd');
      debugPrint('attacker acc: $acc');
      debugPrint('SPD DIF: $countRate');
    }
    var hitRate = 0;
    var missRate = 0;

    if(attacker == 'player'){
      if(!QuestionController.to.answerCorrect.value){
        hitRate = 1;
        missRate = 4;
        if(countRate > 10){
          hitRate++;
        }
      }else if(countRate < 1){
        hitRate = 2;
        missRate = 3;
      }else if(countRate > 0 && countRate <= 15){
        hitRate = 3;
        missRate = 2;
      }else if(countRate > 15){
        hitRate = 4;
        missRate = 1;
      }

      if(EnemyController.to.camouflageOn.value){
        missRate++;
      }

    }else{
      if(countRate < -10){
        hitRate = 1;
        missRate = 4;
      }else if(countRate >= -10 && countRate < 1 ){
        hitRate = 2;
        missRate = 3;
      }else if(countRate > 0 && countRate <= 15 ){
        hitRate = 3;
        missRate = 2;
      }else if(countRate > 15){
        hitRate = 4;
        missRate = 1;
      }

      if(ItemController.to.smokeActive.value){
        missRate++;
      }
    }

    if(kDebugMode){
      debugPrint('Miss rate: $missRate');
      debugPrint('Hit rate: $hitRate');
    }

    for(var i = 0; i < hitRate; i++){
      dodgeRate.add('HIT');
    }
    for(var i = 0; i < missRate; i++){
      dodgeRate.add('MISS');
    }

    var attResult = Random().nextInt(dodgeRate.length);
    if (kDebugMode) {
      debugPrint(dodgeRate[attResult] + '!!!');
    }
    if(dodgeRate[attResult] == 'MISS'){
      addBattleLog(defender: '$defender', message: 'berhasil menghindari serangan', type: 'DODGE');
      effectAnimation.value = 'assets/images/lottie/miss-effect.json';
      
      if(turn.value == 'player'){
        showEnemyAnimation.value = true;
        Timer(const Duration(seconds: 1), (){
          showEnemyAnimation.value = false;
        });
      }else{
        showPlayerAnimation.value = true;
        Timer(const Duration(seconds: 1), (){
          showPlayerAnimation.value = false;
        });
      }

    }
    
    return dodgeRate[attResult];
  }

  addBuff({required String buff, required String receiver}) async {
    try {
      buffObtained = await DBManager.db.getBuff(buffName: buff);
      if(kDebugMode){
        debugPrint('Buff duration: ${buffObtained!.buffDuration}');
        debugPrint('receiver: $receiver');
      }
      switch (buffObtained?.buffType) {
        case 'ATK':
          if(receiver == 'player'){
            CharacterController.to.playerAtk.value = CharacterController.to.playerAtk.value + buffObtained!.buffEffect;
            playerAtkBuff.add(buffObtained!);
          }else{
            EnemyController.to.enemyAtk.value = EnemyController.to.enemyAtk.value + buffObtained!.buffEffect;
            enemyAtkBuff.add(buffObtained!);
          }
          break;
          
        case 'DEF':
          if(receiver == 'player'){
            CharacterController.to.playerDef.value = CharacterController.to.playerDef.value + buffObtained!.buffEffect;
            playerDefBuff.add(buffObtained!);
          }else{
            EnemyController.to.enemyDef.value = EnemyController.to.enemyDef.value + buffObtained!.buffEffect;
            enemyDefBuff.add(buffObtained!);
          }
          break;

        case 'SPD':
          if(receiver == 'player'){
            CharacterController.to.playerSpd.value = CharacterController.to.playerSpd.value + buffObtained!.buffEffect;
            playerSpdBuff.add(buffObtained!);
          }else{
            EnemyController.to.enemySpd.value = EnemyController.to.enemySpd.value + buffObtained!.buffEffect;
            enemySpdBuff.add(buffObtained!);
          }
          break;

        case 'ACC':
          if(receiver == 'player'){
            CharacterController.to.playerAcc.value = CharacterController.to.playerAcc.value + buffObtained!.buffEffect;
            playerAccBuff.add(buffObtained!);
          }else{
            EnemyController.to.enemyAcc.value = EnemyController.to.enemyAcc.value + buffObtained!.buffEffect;
            enemyAccBuff.add(buffObtained!);
          }
          break;

        default:
          if (kDebugMode) {
            debugPrint('BUG: Unkown buff type');
          }
          break;
        }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('BUG: Getting Buff');
        debugPrint('Error: $e');
      }
    }
  }

  removePlayerBuffEffect() {
    if(playerAtkBuff.isNotEmpty){
      for(int i=0; i<playerAtkBuff.length; i++){
        var element = playerAtkBuff[i];
        if(kDebugMode){
          debugPrint('Duration Before: ${element.currentDuration}');
        }
        var dur = element.currentDuration;
        element.currentDuration = dur + 1;
        if(kDebugMode){
          print('Duration After: ${element.currentDuration}');
        }
        if(element.buffDuration == element.currentDuration){
          CharacterController.to.playerAtk.value = CharacterController.to.playerAtk.value - element.buffEffect;
          if(kDebugMode){
            print(CharacterController.to.playerAtk.value);
            debugPrint('REMOVE BUFF');
            debugPrint(element.toString());
          }
        }
        playerAtkBuff.removeWhere((element) => element.buffDuration == element.currentDuration);
      }
    }

    if(playerDefBuff.isNotEmpty){
      for(int i=0; i<playerDefBuff.length; i++){
        var element = playerDefBuff[i];
        if(kDebugMode){
          debugPrint('Duration Before: ${element.currentDuration}');
        }
        var dur = element.currentDuration;
        element.currentDuration = dur + 1;
        if(kDebugMode){
          print('Duration After: ${element.currentDuration}');
          print(CharacterController.to.playerDef.value);
        }
        if(element.buffDuration == element.currentDuration){
          CharacterController.to.playerDef.value = CharacterController.to.playerDef.value - element.buffEffect;
          if(kDebugMode){
            print(CharacterController.to.playerDef.value);
            debugPrint('REMOVE BUFF');
            debugPrint(element.toString());
          }
        }
        playerDefBuff.removeWhere((element) => element.buffDuration == element.currentDuration);
      }
    }

    if(playerSpdBuff.isNotEmpty){
      for(int i=0; i<playerSpdBuff.length; i++){
        var element = playerSpdBuff[i];
        if(kDebugMode){
          debugPrint('Duration Before: ${element.currentDuration}');
        }
        var dur = element.currentDuration;
        element.currentDuration = dur + 1;
        if(kDebugMode){
          print('Duration After: ${element.currentDuration}');
        }
        if(element.buffDuration == element.currentDuration){
          CharacterController.to.playerSpd.value = CharacterController.to.playerSpd.value - element.buffEffect;
          if(kDebugMode){
            print(CharacterController.to.playerDef.value);
            debugPrint('REMOVE BUFF');
            debugPrint(element.toString());
          }
        }
        playerSpdBuff.removeWhere((element) => element.buffDuration == element.currentDuration);
      }
    }

    if(playerAccBuff.isNotEmpty){
      for(int i=0; i<playerAccBuff.length; i++){
        var element = playerAccBuff[i];
        if(kDebugMode){
          debugPrint('Duration Before: ${element.currentDuration}');
        }
        var dur = element.currentDuration;
        element.currentDuration = dur + 1;
        if(kDebugMode){
          print('Duration After: ${element.currentDuration}');
        }
        if(element.buffDuration == element.currentDuration){
          CharacterController.to.playerAcc.value = CharacterController.to.playerAcc.value - element.buffEffect;
          if(kDebugMode){
            print(CharacterController.to.playerDef.value);
            debugPrint('REMOVE BUFF');
            debugPrint(element.toString());
          }
        }
        playerAccBuff.removeWhere((element) => element.buffDuration == element.currentDuration);
      }
    }
  }

  removeEnemyBuffEffect() {
    if(enemyAtkBuff.isNotEmpty){
      for(int i=0; i<enemyAtkBuff.length; i++){
        var element = enemyAtkBuff[i];
        if(kDebugMode){
          debugPrint('Duration Before: ${element.currentDuration}');
        }
        var dur = element.currentDuration;
        element.currentDuration = dur + 1;
        if(kDebugMode){
          print('Duration After: ${element.currentDuration}');
        }
        if(element.buffDuration == element.currentDuration){
          EnemyController.to.enemyAtk.value = EnemyController.to.enemyAtk.value - element.buffEffect;
          if(kDebugMode){
            print(EnemyController.to.enemyAtk.value);
            debugPrint('REMOVE BUFF');
            debugPrint(element.toString());
          }
        }
        enemyAtkBuff.removeWhere((element) => element.buffDuration == element.currentDuration);
      }
    }

    if(enemyDefBuff.isNotEmpty){
      for(int i=0; i<enemyDefBuff.length; i++){
        var element = enemyDefBuff[i];
        if(kDebugMode){
          debugPrint('Enemy Buff Duration Before: ${element.currentDuration}');
        }
        var dur = element.currentDuration;
        element.currentDuration = dur + 1;
        if(kDebugMode){
          print('Enemy Buff Duration After: ${element.currentDuration}');
        }
        if(element.buffDuration == element.currentDuration){
          EnemyController.to.enemyDef.value = EnemyController.to.enemyDef.value - element.buffEffect;
          if(kDebugMode){
            print(EnemyController.to.enemyDef.value);
            debugPrint('REMOVE BUFF');
            debugPrint(element.toString());
          }
        }
        enemyDefBuff.removeWhere((element) => element.buffDuration == element.currentDuration);
      }
    }

    if(enemySpdBuff.isNotEmpty){
      for(int i=0; i<enemySpdBuff.length; i++){
        var element = enemySpdBuff[i];
        if(kDebugMode){
          debugPrint('Duration Before: ${element.currentDuration}');
        }
        var dur = element.currentDuration;
        element.currentDuration = dur + 1;
        if(kDebugMode){
          print('Duration After: ${element.currentDuration}');
        }
        if(element.buffDuration == element.currentDuration){
          EnemyController.to.enemySpd.value = EnemyController.to.enemySpd.value - element.buffEffect;
          if(kDebugMode){
            print(EnemyController.to.enemySpd.value);
            debugPrint('REMOVE BUFF');
            debugPrint(element.toString());
          }
        }
        enemySpdBuff.removeWhere((element) => element.buffDuration == element.currentDuration);
      }
    }

    if(enemyAccBuff.isNotEmpty){
      for(int i=0; i<enemyAccBuff.length; i++){
        var element = enemyAccBuff[i];
        if(kDebugMode){
          debugPrint('Duration Before: ${element.currentDuration}');
        }
        var dur = element.currentDuration;
        element.currentDuration = dur + 1;
        if(kDebugMode){
          print('Duration After: ${element.currentDuration}');
        }
        if(element.buffDuration == element.currentDuration){
          EnemyController.to.enemyAcc.value = EnemyController.to.enemyAcc.value - element.buffEffect;
          if(kDebugMode){
            print(EnemyController.to.enemyAcc.value);
            debugPrint('REMOVE BUFF');
            debugPrint(element.toString());
          }
        }
        enemyAccBuff.removeWhere((element) => element.buffDuration == element.currentDuration);
      }
    }
  }

  addBattleLog({String? attacker, String? defender, required String message, required String type}) {
    if(battleLog.length == 10){
      battleLog.removeAt(0);
    }
    switch (type) {
      case 'ATK':
        battleLog.add('$defender $message $attacker.');
        break;
      case 'DODGE':
        battleLog.add('$defender $message.');
        break;
      case 'DEFEND':
        battleLog.add('$defender $message');
        break;
      case 'DEFEAT':
        battleLog.add('$attacker $message $defender.');
        break;
      case 'USE ITEM':
        battleLog.add(message);
        break;
      case 'FREE':
        battleLog.add(message);
        break;
      default:
    }
  }
}