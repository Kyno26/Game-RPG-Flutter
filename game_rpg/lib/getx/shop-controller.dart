// ignore_for_file: file_names

import 'package:game_rpg/getx/character-controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ShopController extends GetxController{
  static ShopController get to => Get.find<ShopController>();

  static const _local = "ID";
  String _formatCur(String source) => NumberFormat.decimalPattern(_local).format(int.parse(source));

  RxInt totalCoins = 0.obs;
  RxInt coinGetBattle = 0.obs;

  addCoins({required int coinAdded}) {
    int currentCoin = totalCoins.value;
    totalCoins.value = currentCoin + coinAdded;
  }

  decreaseCoins({required int coinRemoved}) {
    int currentCoin = totalCoins.value;
    totalCoins.value = currentCoin - coinRemoved;
  }

  formatCoins() {

    int coins = totalCoins.value;
    if (coins > 999 && coins < 99999) {
      // return "${(coins / 1000).toStringAsFixed(1)} K";
      return _formatCur(coins.toString());
    } else if (coins > 99999 && coins < 999999) {
      return "${(coins / 1000).toStringAsFixed(0)} K";
    } else if (coins > 999999 && coins < 999999999) {
      return "${(coins / 1000000).toStringAsFixed(1)} M";
    } else if (coins > 999999999) {
      return "${(coins / 1000000000).toStringAsFixed(1)} B";
    } else {
      return _formatCur(coins.toString());
    }
  }

  unlockNewCharacter({required int characterId}) {
    var unlocked = CharacterController.to.checkCharacterUnlockStatus(characterId: characterId);
    if(!unlocked){
      switch(characterId) {
        case 1:
          return CharacterController.to.yingUnlocked.value = true;
        case 2:
          return CharacterController.to.kayaUnlocked.value = true;
        case 3:
          return CharacterController.to.nimiUnlocked.value = true;
        case 4:
          return CharacterController.to.chloeUnlocked.value = true;
        case 5:
          return CharacterController.to.sakuyaUnlocked.value = true;
      }
    }
  }
}