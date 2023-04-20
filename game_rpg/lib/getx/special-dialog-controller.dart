// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:game_rpg/getx/shop-controller.dart';
import 'package:game_rpg/widgets/popup-dialog/game-over-dialog.dart';
import 'package:game_rpg/widgets/popup-dialog/get-item-dialog.dart';
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
}