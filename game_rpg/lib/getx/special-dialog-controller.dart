// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:game_rpg/getx/shop-controller.dart';
import 'package:game_rpg/widgets/popup-dialog/game-over-dialog.dart';
import 'package:game_rpg/widgets/popup-dialog/get-debuff-dialog.dart';
import 'package:game_rpg/widgets/popup-dialog/get-item-dialog.dart';
import 'package:game_rpg/widgets/popup-dialog/level-up-dialog.dart';
import 'package:get/get.dart';

class SpecialDialogController extends GetxController{
  late BuildContext context;

  static SpecialDialogController get to => Get.find<SpecialDialogController>();

  SpecialDialogController({required this.context});

  void showGameOverDialog() {
    Future.delayed(Duration.zero, (){
      showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: GameOverDialog(
              enemyDefeated: BattleFieldController.to.enemyDefeated.value.toString(), 
              score: QuestionController.to.currentScore.value.toString(), 
              coinsEarned: ShopController.to.coinGetBattle.value.toString()
            ) 
          );
        }
      );
    });
  }

  void showitemGetDialog() {
    Future.delayed(Duration.zero, (){
      showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const GetItemDialog() 
          );
        }
      );
    });
  }

  void showPoisonDebuff() {
    Future.delayed(Duration.zero, (){
      showDialog(
        context: context, 
        builder: (context) {
          return GetDebuffDialog(
            title: 'Efek Negatif', 
            content: 'Anda terkena racun, pertahanan anda menurun dan menerima 5 damage selama beberapa giliran', 
            onPress: () => Navigator.pop(context)
          );
        }
      );
    });
  }

  void showBurnDebuff() {
    Future.delayed(Duration.zero, (){
      showDialog(
        context: context, 
        builder: (context) {
          return GetDebuffDialog(
            title: 'Efek Negatif', 
            content: 'Anda terkena semburan api, anda akan menerima 5 damage selama beberapa giliran', 
            onPress: () => Navigator.pop(context)
          );
        }
      );
    });
  }

  void showGasDebuff() {
    Future.delayed(Duration.zero, (){
      showDialog(
        context: context, 
        builder: (context) {
          return GetDebuffDialog(
            title: 'Efek Negatif', 
            content: 'Anda terkena semprotan gas, anda tidak dapat menyerang selama 2 giliran', 
            onPress: () => Navigator.pop(context)
          );
        }
      );
    });
  }

  void levelUp({required String title, required String content}) {
    Future.delayed(Duration.zero, (){
      showDialog(
        context: context, 
        builder: (context) {
          return LevelUpDialog(
            title: title, 
            content: content, 
            onPress: () => Navigator.pop(context)
          );
        }
      );
    });
  }

  void necklaseUsed() {
    Future.delayed(Duration.zero, (){
      showDialog(
        context: context, 
        builder: (context) {
          return LevelUpDialog(
            title: 'Kesempatan Kedua', 
            content: 'Item Jimat Penyelamat digunakan, nyawa dipulihkan seperti semula!', 
            onPress: () => Navigator.pop(context)
          );
        }
      );
    });
  }
}