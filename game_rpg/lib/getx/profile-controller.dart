// ignore_for_file: file_names, 

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/component/shared-preferences-data/user-data.dart';
import 'package:game_rpg/getx/shop-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  static ProfileController get to => Get.find<ProfileController>();

  RxBool continueGameStatus = false.obs;
  RxInt highScore = 0.obs;
  RxInt highestQuestionAnswered = 0.obs;

  RxString loadPhase = '1'.obs;
  RxString loadMessage = 'Waiting...'.obs;
  RxBool loadState = true.obs;

  RxInt currentDataVersion = 1.obs;
  RxInt existingDataVersion = 1.obs;
  RxInt currentDatabaseVersion = 1.obs;
  RxInt existingDatabaseVersion = 1.obs;
  RxString appReleaseVersion = '1.0.0'.obs;

  setDefaultValue(){
    ShopController.to.totalCoins.value = 0;
    continueGameStatus.value = false;
    highScore.value = 0;
    highestQuestionAnswered.value = 0;
    
    CharacterController.to.yingUnlocked.value = true;
    CharacterController.to.kayaUnlocked.value = false;
    CharacterController.to.nimiUnlocked.value = false;
    CharacterController.to.chloeUnlocked.value = false;
    CharacterController.to.sakuyaUnlocked.value = false;
  }

  /*
  UPDATE CONTINUE GAME STATUS
  */
  setContinueGameStatus({required bool gameStatus}) {
    continueGameStatus.value = gameStatus;
  }

  setHighScore({required int newHighScore, required int totalAnswered}) {
    highScore.value = newHighScore;
    highestQuestionAnswered.value = totalAnswered;
  }
  
  /*
  ======================== LOADING PHASE ========================
  note:
    - phase 1 = Initializing
    - phase 2 = User Data
    - phase 3 = Game Data
    - phase 4 = Checking Version
    - phase 5 = Loading Success
  */

  loadStart() async {
    if (kDebugMode) {
      debugPrint('===== LOAD START =====');
    }
    loadState.value = true;
    loadPhase.value = '1';
    loadMessage.value = 'Initializing';

    CharacterController.to.resetValue();
    Timer(const Duration(seconds: 2), () {
      loadingUserData();
    });
  }

  loadingUserData() async {
    loadPhase.value = '2';
    loadMessage.value = 'Creating user data';
    if(await checkUserDataExist() == false){
      if (kDebugMode) {
        debugPrint('===== CREATING DATA =====');
      }
      Timer(const Duration(seconds: 2), () {
        createConfigData();
        setDefaultValue();
        loadGameData();
      });
    }else{
      if (kDebugMode) {
        debugPrint('===== LOAD USER DATA =====');
      }
      Timer(const Duration(seconds: 2), () {
        loadGameData();
      });
    }
  }

  loadGameData() async {
    loadPhase.value = '3';
    loadMessage.value = 'Checking game data';
    await DBManager.db.createDatabaseInstance().then((value) {
      Timer(const Duration(seconds: 2), (){
        checkDataVersion();
      });
    });
  }

  checkDataVersion() async {
    loadPhase.value = '4';
    loadMessage.value = 'Checking data version';
    if (kDebugMode) {
      debugPrint('===== CHECKING DATA VERSION =====');
    }
    if(existingDataVersion.value != currentDataVersion.value){
      loadMessage.value = 'Updating data';
      //code
      Timer(const Duration(seconds: 2), (){
        loadFinish();
      });
    }else{
      Timer(const Duration(seconds: 2), (){
        loadFinish();
      });
    }
  }

  loadFinish() async {
    loadPhase.value = '5';
    loadMessage.value = 'init success';
    if (kDebugMode) {
      debugPrint('===== LOAD COMPLETE =====');
    }
    Timer(const Duration(milliseconds: 1500), (){
      loadMessage.value = ' ';
      loadState.value = false;
    });
  }
}