// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/shared-preferences-data/global-sharedpreferences.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/audio-controller.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/item-controller.dart';
import 'package:get/get.dart';

class LevelSelectDialog extends StatefulWidget{
  const LevelSelectDialog({super.key});

  @override
  State<LevelSelectDialog> createState() => _LevelSelectDialogState();
}

class _LevelSelectDialogState extends State<LevelSelectDialog> {
  int selected = 1;
  bool stage1 = true;
  bool stage2 = false;
  bool stage3 = false;
  bool stage4 = false;

  int stageSelected = 1;

  getStageProgress() async {
    var s2 = await getBoolLocalData('stage2_unlocked') as bool;
    var s3 = await getBoolLocalData('stage3_unlocked') as bool; 
    var s4 = await getBoolLocalData('stage4_unlocked') as bool;
    setState(() {
      stage2 = s2;
      stage3 = s3;
      stage4 = s4;
    });
    print('stage 2 status: $stage2');
    print('stage 3 status: $stage3');
    print('stage 4 status: $stage4');
  }

  @override
  void initState() {
    getStageProgress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage('assets/images/background/tableBG.jpg'),
              fit: BoxFit.fill
            )
          ),
          child: Column(
            children: [
              SizedBox(height: Spacing.smallSpacing),
              Center(
                child: Text('Pilih Level',
                  style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(
                      fontFamily: 'Scada',
                      fontWeight: FontWeight.w600,
                      fontSize: averageText,
                      color: Colors.black
                    ),
                )
              ),
              SizedBox(height: Spacing.mediumSpacing),
              // Obx(() => 
              levelOptBtn(
                stage: 'Stage 1-1', 
                subject: 'Sistem Pernapasan', 
                stageStatus: stage1, 
                onPress: (){
                  setState(() {
                    selected = 1;
                    stageSelected = 1;
                  });
                }, 
                selected: selected, 
                index: 1
              // )
              ),
              SizedBox(height: Spacing.smallSpacing),
              // Obx(() => 
              levelOptBtn(
                stage: 'Stage 2-1', 
                subject: 'Sistem Pencernaan', 
                stageStatus: stage2, 
                onPress: (){
                  setState(() {
                    selected = 2;
                    stageSelected = 6;
                  });
                },
                selected: selected, 
                index: 2
              // )
              ),
              SizedBox(height: Spacing.smallSpacing),
              // Obx(() => 
              levelOptBtn(
                stage: 'Stage 3-1', 
                subject: 'Sistem Pertahanan Tubuh', 
                stageStatus: stage3, 
                onPress: (){
                  setState(() {
                    selected = 3;
                    stageSelected = 11;
                  });
                },
                selected: selected, 
                index: 3
              // )
              ),
              SizedBox(height: Spacing.smallSpacing),
              // Obx(() => 
              levelOptBtn(
                stage: 'Stage 4-1', 
                subject: 'Semua Materi', 
                stageStatus: stage4, 
                onPress: (){
                  setState(() {
                    selected = 4;
                    stageSelected = 16;
                  });

                },
                selected: selected, 
                index: 4
              // )
              ),
              SizedBox(height: Spacing.mediumSpacing),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    if(selected != 0){
                      AudioController.to.lobbyBGM.dispose();
                      CharacterController.to.selectCharacter(
                        name: CharacterController.to.selectedCharacterName.value,
                        image: CharacterController.to.selectedCharacterPotraitImage.value, 
                        hp: CharacterController.to.selectedCharacterHP.value, 
                        atk: CharacterController.to.selectedCharacterAttack.value, 
                        def: CharacterController.to.selectedCharacterDefense.value, 
                        spd: CharacterController.to.selectedCharacterSpeed.value, 
                        acc: CharacterController.to.selectedCharacterAccuracy.value, 
                        crit: CharacterController.to.selectedCharacterCritRate.value,
                        atkEffect: CharacterController.to.selectedCharacterAtkEffect.value
                      );
                      BattleFieldController.to.storyRound.value = stageSelected;
                      BattleFieldController.to.stageCountController(BattleFieldController.to.storyRound.value);

                      Navigator.pop(context);
                      BattleFieldController.to.resetBattlegroundData(stage: BattleFieldController.to.storyRound.value);

                      if(BattleFieldController.to.storyRound.value == 6){
                        CharacterController.to.upgradePointOwned.value = CharacterController.to.upgradePointOwned.value + 10;
                        CharacterController.to.upgradePointAvailable.value = CharacterController.to.upgradePointAvailable.value + 10;
                        
                        ItemController.to.addItem(itemID: 1);
                        ItemController.to.addItem(itemID: 1);
                        ItemController.to.addItem(itemID: 5);

                      }else if(BattleFieldController.to.storyRound.value == 11){
                        CharacterController.to.upgradePointOwned.value = CharacterController.to.upgradePointOwned.value + 20;
                        CharacterController.to.upgradePointAvailable.value = CharacterController.to.upgradePointAvailable.value + 20;

                        ItemController.to.addItem(itemID: 1);
                        ItemController.to.addItem(itemID: 2);
                        ItemController.to.addItem(itemID: 4);
                        ItemController.to.addItem(itemID: 11);

                      }else if(BattleFieldController.to.storyRound.value == 16){
                        CharacterController.to.upgradePointOwned.value = CharacterController.to.upgradePointOwned.value + 35;
                        CharacterController.to.upgradePointAvailable.value = CharacterController.to.upgradePointAvailable.value + 35;

                        ItemController.to.addItem(itemID: 6);
                        ItemController.to.addItem(itemID: 1);
                        ItemController.to.addItem(itemID: 10);
                        ItemController.to.addItem(itemID: 11);
                        ItemController.to.addItem(itemID: 11);
                      }

                      Navigator.pushReplacementNamed(context, 'battlefield');
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smallSpacing, vertical: 8),
                    backgroundColor: (selected != 0) ? Colors.green : Colors.white,
                    fixedSize: Size.fromWidth(MediaQuery.of(context).size.width * 0.3),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: (selected != 0) ? Colors.green.shade700 : Colors.black54, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    shadowColor: Colors.green.shade800,
                    elevation: 3,
                  ),
                  child: Text('Mulai',
                    style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(
                        fontFamily: 'Scada',
                        fontWeight: FontWeight.w600,
                        fontSize: smallText,
                        color: Colors.white
                      ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget levelOptBtn({
      required String stage, 
      required String subject, 
      required bool stageStatus, 
      required Function() onPress,
      required int selected,
      required int index,
    }){
    if (stageStatus) {
      return GestureDetector(
        onTap: onPress,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          padding: EdgeInsets.all(Spacing.smallSpacing),
          decoration: BoxDecoration(
            border: Border.all(color: (selected == index) ? Colors.green.shade600 : Colors.black, width: 2),
            borderRadius: BorderRadius.circular(5),
            color: (selected == index) ? Colors.green :Colors.white
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(stage,
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: smallText,
                    color: (selected == index) ? Colors.white : Colors.black
                  ),
              ),
              Text('Materi: $subject',
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w500,
                    fontSize: smallText,
                    color: (selected == index) ? Colors.white70 : Colors.black87
                  ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        padding: EdgeInsets.all(Spacing.smallSpacing),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline_rounded, color: Colors.black),
            Text('Level Terkunci',
              style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w700
                ),
            )
          ],
        ),
      ); 
    }
  }

}