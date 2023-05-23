import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/audio-controller.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/enemy-controller.dart';
import 'package:game_rpg/getx/special-dialog-controller.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:game_rpg/widgets/action-button.dart';
import 'package:game_rpg/widgets/battle_log.dart';
import 'package:game_rpg/widgets/popup-dialog/enemy-stat-detail.dart';
import 'package:game_rpg/widgets/popup-dialog/info-detail.dart';
import 'package:game_rpg/widgets/confirm-dialog/exit-battle-dialog.dart';
import 'package:game_rpg/widgets/popup-dialog/use-item-dialog.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class BattleField extends StatefulWidget{
  const BattleField({super.key});

  @override
  State<BattleField> createState() => _BattleFieldState();
}

class _BattleFieldState extends State<BattleField> {

  bool isScreenLoading = true;
  late Image imageBG;
  late Image killCountBoard;
  late Image actionBoard;
  late Image actionButton;
  late Image logBg;

  final bgmPlayer = AssetsAudioPlayer.withId('BGM');

  bool startGame = false;

  @override
  void initState() {
    BattleFieldController.to.bgSelector();
    imageBG = Image.asset(BattleFieldController.to.imageBG.value);
    actionButton = Image.asset('assets/images/background/wood-platform.png');
    killCountBoard = Image.asset('assets/images/background/wood.jpg');
    actionBoard = Image.asset('assets/images/background/wood-texture.jpg');
    logBg = Image.asset('assets/images/background/scroll-parchment.png');
    BattleFieldController.to.initializeSystem();
    super.initState();
    
    playBgm();
  }

  void playBgm() async {
    await bgmPlayer.open(
      Audio('assets/audio/battle-1-BGM.mp3'),
      loopMode: LoopMode.single,
      autoStart: true,
      showNotification: false,
      respectSilentMode: false,
      volume: 0.5,
    );
  }

  @override
  void didChangeDependencies() {
    precacheImage(imageBG.image, context);
    precacheImage(killCountBoard.image, context);
    precacheImage(actionBoard.image, context);
    precacheImage(actionButton.image, context);
    precacheImage(logBg.image, context);
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isScreenLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Get.delete<SpecialDialogController>();
    bgmPlayer.dispose();
    // AudioController.to.bgmPlayer1.dispose();
    AudioController.to.slashAtkBGM1.dispose();
    AudioController.to.critSlashAtkBGM1.dispose();
    AudioController.to.playLobbyBgm();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Get.put(SpecialDialogController(context: context));
    final SpecialDialogController specialDialogCtrl = Get.put(SpecialDialogController(context: context));

    return WillPopScope(
      onWillPop: () async {
        if(!BattleFieldController.to.startBattle.value){
          showDialog(
            context: context, 
            builder: (context) {
              return ExitBattleDialog(
                title: 'PERINGATAN', 
                content: 'Apakah anda yakin ingin kembali ke menu utama?', 
                yesText: 'Kembali', 
                yesAction: () {
                  // Navigator.popUntil(context, ModalRoute.withName('mainMenuScreen'));
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, 'mainMenuScreen', (route) => route.isFirst);
                }, 
                noText: 'Batal',
                noAction: () {
                  Navigator.pop(context);
                }, 
              );
            }
          );
        }
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: mainContent(),
        )
      ), 
    );
  }

  Widget mainContent(){
    if(!isScreenLoading){
      return Obx(() => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(BattleFieldController.to.imageBG.value),
            fit: BoxFit.fill
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: Spacing.smallSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      SizedBox(width: Spacing.smallSpacing),
                      Obx(() => Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing),
                        decoration: BoxDecoration(
                          color: (BattleFieldController.to.turn.value == 'waiting') ? softGreyColor : (BattleFieldController.to.turn.value == 'player') ? greenColor : redColor,
                          border: Border.all(color: (BattleFieldController.to.turn.value == 'player') ? Colors.white : Colors.black)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                              height: MediaQuery.of(context).size.width * 0.05,
                              child: SvgPicture.asset(BattleFieldController.to.turnIcon.value, fit: BoxFit.fill,),
                            ),
                            Text('${BattleFieldController.to.turn.value} turn',
                              style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  fontFamily: 'Scada',
                                  fontSize: smallText,
                                  fontWeight: FontWeight.w500,
                                  color: (BattleFieldController.to.turn.value == 'player') ? Colors.white : Colors.black
                                ),
                            ),
                          ],
                        )
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Spacing.smallSpacing),
                        decoration: BoxDecoration(
                          color: Colors.brown.shade400,
                          border: Border.all(color: Colors.black54, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/background/wood.jpg'),
                            fit: BoxFit.fill
                          ),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Text('Stage: ',
                                style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontFamily: 'Scada',
                                    fontSize: smallText,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                  ),
                              ),
                              Obx(() => Text(BattleFieldController.to.stageText.value,
                                style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontFamily: 'Scada',
                                    fontSize: smallText,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),
                                )
                              ),
                            ],
                          )
                        ),
                      ),
                      SizedBox(width: Spacing.smallSpacing),
                      GestureDetector(
                        onTap: () {
                          if (!BattleFieldController.to.startBattle.value) {
                            //pause popup dialog
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return ExitBattleDialog(
                                  title: 'PERINGATAN', 
                                  content: 'Apakah anda yakin ingin kembali ke menu utama?', 
                                  yesText: 'Kembali', 
                                  yesAction: () {
                                    // Navigator.popUntil(context, ModalRoute.withName('mainMenuScreen'));
                                    Navigator.pop(context);
                                    Navigator.pushNamedAndRemoveUntil(context, 'mainMenuScreen', (route) => route.isFirst);
                                  }, 
                                  noText: 'Batal',
                                  noAction: () {
                                    Navigator.pop(context);
                                  }, 
                                );
                              }
                            );
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            border: Border.all(color: plainBlackBackground, width: 1),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: SvgPicture.asset('assets/icons/pause-icon.svg', fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(width: Spacing.smallSpacing),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: Spacing.smallSpacing),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context, 
                    builder: (context) {
                      return const BattleLog();
                    }
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(right: Spacing.smallSpacing),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: SvgPicture.asset('assets/icons/log-icon.svg', fit: BoxFit.fill),
                ),
              ),
            ),
            const Spacer(flex: 2),
            Obx(() => (BattleFieldController.to.enemyActive.value)
            ? Center(
              child: Obx(() => SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.25,
                // color: Colors.blue,
                child: Column(
                  children: [
                    Container(
                      width: (EnemyController.to.enemyPassive.value == 'normal') ? MediaQuery.of(context).size.width * 0.45 : MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(EnemyController.to.enemyImage.value),
                          fit: BoxFit.fill
                        )
                      ),
                      child: (BattleFieldController.to.showEnemyAnimation.value)
                        ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Lottie.asset(BattleFieldController.to.effectAnimation.value, fit: BoxFit.fill),
                        )
                        : null,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        border: Border.all(color: Colors.black45)
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(EnemyController.to.enemyName.value,
                              style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  fontFamily: 'Scada',
                                  fontSize: smallText,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                                height: MediaQuery.of(context).size.width * 0.05,
                                child: SvgPicture.asset('assets/icons/heart-icon.svg', fit: BoxFit.fill),
                              ),
                              Obx(() => Text('HP: ${EnemyController.to.enemyHealth.value} /  ${EnemyController.to.enemyMaxHealth.value}',
                                style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontFamily: 'Scada',
                                    fontSize: smallText,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                              )),
                              SizedBox(width: Spacing.smallSpacing),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context, 
                                    builder: (context) {
                                      return const EnemyStatDetail();
                                    }
                                  );
                                },
                                child: Text('Detail',
                                  style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontFamily: 'Scada',
                                      decoration: TextDecoration.underline,
                                      fontSize: smallText,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),)
            )
            : SizedBox(height: MediaQuery.of(context).size.height * 0.25)),
            SizedBox(height: Spacing.largeSpacing * 2),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown.shade500, width: 1),
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background/wood-texture.jpg'),
                  fit: BoxFit.fill
                )
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(Spacing.mediumSpacing),
                    decoration: const BoxDecoration(
                      border: Border(right: BorderSide(color: Colors.black54, width: 2))
                    ),
                    child: Column(
                      children: [
                        Obx(() => Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: MediaQuery.of(context).size.width * 0.2,
                              decoration: BoxDecoration(
                                color: Colors.cyan.shade100,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 1),
                                image: DecorationImage(
                                  image: AssetImage(CharacterController.to.playerCharacterImage.value)
                                )
                              ),
                            ),
                            if(CharacterController.to.playerHit.value)
                            Opacity(
                              opacity: 0.7,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.width * 0.2,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle
                                ),
                              ),
                            )
                          ],
                        )),
                        Obx(() => SizedBox(
                          // height: MediaQuery.of(context).size.width * 0.2,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.05,
                                    height: MediaQuery.of(context).size.width * 0.05,
                                    child: SvgPicture.asset('assets/icons/heart-icon.svg', fit: BoxFit.fill),
                                  ),
                                  Text('HP: ${CharacterController.to.playerHealth.value}/${CharacterController.to.playerMaxHealth.value}',
                                    style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        fontSize: smallText,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white
                                      ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Spacing.smallSpacing),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context, 
                                      builder: (context) {
                                        return const InfoDetail();
                                      }
                                    );
                                  },
                                  child: Text('Detail',
                                    style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        decoration: TextDecoration.underline,
                                        fontSize: smallText,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                      ),
                                  ),
                                )
                              )
                            ],
                          ),
                        ),)
                      ],
                    )
                  ),
                  Expanded(
                    child: Obx(() =>
                      Container(
                        padding: EdgeInsets.all(Spacing.mediumSpacing),
                        child: (!BattleFieldController.to.startBattle.value)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ActionButton(
                                title: 'Mulai', 
                                onPress: () {
                                  if(!BattleFieldController.to.enemyActive.value){
                                    // BattleFieldController.to.enemyLvl1Generate();
                                    BattleFieldController.to.enemyActive.value = true;
                                  }
                                  BattleFieldController.to.startBattle.value = true;
                                  QuestionController.to.showQuestion(context: context);
                                },
                              ),
                              SizedBox(height: Spacing.smallSpacing),
                              Text('(Permainan tidak dapat di "pause" atau dijeda sampai giliran berakhir)',
                                style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontFamily: 'Scada',
                                    fontSize: smallText,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w500,
                                    color: darkYellowColor
                                  ),
                              )
                            ]
                          )
                        : (BattleFieldController.to.turn.value == 'player')
                          ? Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ActionButton(
                                    title: 'Serang', 
                                    onPress: () async {
                                      if(!EnemyController.to.gasOn.value){
                                        CharacterController.to.playerPhase(actionSelected: 'Attack');
                                      }else{
                                        var count = EnemyController.to.maxGasDuration.value - EnemyController.to.curGasDuration.value;
                                        showDialog(
                                          context: context,
                                          builder: (context){
                                            return Center(
                                              child: Container(
                                                width: MediaQuery.of(context).size.width * 0.8,
                                                height: MediaQuery.of(context).size.height * 0.25,
                                                color: Colors.transparent,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.7,
                                                      height: MediaQuery.of(context).size.height * 0.15,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(context).size.width * 0.8,
                                                            height: MediaQuery.of(context).size.height * 0.05,
                                                            decoration: BoxDecoration(
                                                              color: Colors.yellow.shade700,
                                                              // border: Border(bottom: BorderSide(color: plainBlackBackground, width: 1)),
                                                              borderRadius: BorderRadius.only(
                                                                topLeft: Radius.circular(8),
                                                                topRight: Radius.circular(8)
                                                              )
                                                            ),
                                                            child: Center(
                                                              child: Text('Peringatan',
                                                                style: Theme.of(context)
                                                                  .textTheme
                                                                  .headline6!
                                                                  .copyWith(
                                                                    fontFamily: 'Scada',
                                                                    fontSize: smallText,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: Colors.white
                                                                  ),
                                                              ),
                                                            )
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(context).size.width * 0.8,
                                                            height: MediaQuery.of(context).size.height * 0.1,
                                                            padding: EdgeInsets.symmetric(horizontal: Spacing.smallSpacing),
                                                            // color: Colors.yellow,
                                                            child: Center(
                                                              child: Text('Anda tidak dapat menyerang akibat dari status negatif selama $count giliran',
                                                                textAlign: TextAlign.center,
                                                                style: Theme.of(context)
                                                                  .textTheme
                                                                  .headline5!
                                                                  .copyWith(
                                                                    fontFamily: 'Scada',
                                                                    fontSize: smallText,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: Colors.black
                                                                  ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                      }
                                    }
                                  ),
                                  SizedBox(width: Spacing.mediumSpacing),
                                  ActionButton(
                                    title: 'Bertahan', 
                                    onPress: (){
                                      CharacterController.to.playerPhase(actionSelected: 'Defend', buffName: 'Base Defend');
                                    }
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // ActionButton(
                                  //   title: 'Inventory', 
                                  //   onPress: (){
                                  //     //code
                                  //   }
                                  // ),
                                  // SizedBox(width: Spacing.mediumSpacing),
                                  ActionButton(
                                    title: 'Item', 
                                    onPress: (){
                                      // for(var i = 0; i < CharacterController.to.itemList.length; i++){
                                      //   print(CharacterController.to.itemList[i]);
                                      // }
                                      // print(CharacterController.to.itemList.length);
                                      CharacterController.to.selectedItemID.value = '';
                                      showDialog(
                                        context: context,
                                        builder: (context) => const UseItemDialog()
                                      );
                                    }
                                  ),
                                ],
                              )
                            ],
                          )
                          : Center(
                            child: Text('Menunggu giliran musuh selesai...',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                  fontFamily: 'Scada',
                                  fontSize: averageText,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87
                                ),
                            ),
                          )
                      )
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }else{
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: plainBlackBackground,
        child: Center(
          child: FadeIn(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(seconds: 1),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Lottie.asset('assets/images/lottie/load-animation.json', 
                fit: BoxFit.fill, 
                repeat: true
              ),
            ),
          )
        ),
      );
    }
  }

}