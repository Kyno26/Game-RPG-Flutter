// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/widgets/confirm-dialog/exit-dialog.dart';
import 'package:game_rpg/widgets/confirm-dialog/new-game_dialog.dart';

Future<bool> exitDialoguePopup(BuildContext context) async {
  late bool exitGame;
  await showDialog(
    context: context, 
    builder: (context) {
      return ExitDialog(
        title: 'Apakah anda yakin ingin keluar dari permainan?', 
        yesBtnPressed: () {
          exitGame = true;
          Navigator.of(context).pop();
        }, 
        yesContent: 'Keluar', 
        noBtnPressed: () {
          exitGame = false;
          Navigator.of(context).pop();
        }, 
        noContent: 'Batal'
      );
    }
  );
  return exitGame;
}

Future<bool> newGameDialog(BuildContext context) async {
  late bool newGame;
  await showDialog(
    context: context, 
    builder: (context) {
      return NewGameDialog(
        title: 'Apakah anda yakin ingin memulai permainan baru?', 
        subTitle: 'Progres yang anda mainkan sebelumnya akan hilang',
        yesBtnPressed: () {
          newGame = true;
          Navigator.of(context).pop();
          Navigator.pushNamed(context, 'characterSelectScreen');
        }, 
        yesContent: 'Ya', 
        noBtnPressed: () {
          newGame = false;
          Navigator.of(context).pop();
        }, 
        noContent: 'Batal',
      );
    }
  );
  return newGame;
}