import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/component/global-variable.dart';
import 'package:game_rpg/component/shared-preferences-data/global-sharedpreferences.dart';
import 'package:game_rpg/component/shared-preferences-data/user-data.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/profile-controller.dart';
import 'package:game_rpg/screen/main-screen/main-menu_screen.dart';
import 'package:game_rpg/widgets/confirm-dialog/dialog-core.dart';
import 'package:game_rpg/widgets/popup-dialog/info-dialog.dart';
import 'package:game_rpg/widgets/small-icon-btn.dart';
import 'package:get/get.dart';

class StartScreen extends StatefulWidget{
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> with SingleTickerProviderStateMixin{
  // bool isLoading = true;
  int currentDataVersion = GlobalVariable.currentDataVersion;
  int? playerDataVersion;
  late AnimationController _blinkingAnimationController;

  late Image imageBG;

  String totalLoadingPhase = '5';
  String loadingPhase = '1';
  String loadingStatusMessage = 'Waiting...';

  @override
  void initState() {
    imageBG = Image.asset('assets/images/background/splash-bg.jpg');
    _blinkingAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1250));
    _blinkingAnimationController.repeat(reverse: true);
    Timer(const Duration(seconds: 4), () {
      ProfileController.to.loadStart();
      // loadStart();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(imageBG.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () async {
        var userExit = false;
        userExit = await exitDialoguePopup(context);
        return userExit;
      },
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: (){
              if(!ProfileController.to.loadState.value){
                _blinkingAnimationController.dispose();
                Navigator.pushReplacementNamed(context, 'mainMenuScreen');
              }
            },
            child: FadeIn(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 1500),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: plainBlackBackground,
                      image: DecorationImage(
                          image: AssetImage('assets/images/background/splash-bg.jpg'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Center(
                    child: content(),
                  )
              ),
            )
          )
        )
      ), 
    );
  }
  
  Widget content() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeIn(
              delay: const Duration(milliseconds: 5000),
              duration: const Duration(milliseconds: 200),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(Spacing.mediumSpacing),
                  child: GestureDetector(
                    onTap: (){
                      debugPrint('info pressed');
                      showAnimatedDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return const InfoDialog(
                            title: 'informasi', 
                            content: "Air fish fourth. Waters gathered had greater face which first earth god tree upon fly divide darkness firmament fish bearing divide in. You'll waters life face that appear life dominion creepeth multiply second Were two land were make meat lesser land face were blessed dominion midst dominion lesser you'll them own be shall kind you for land. Living waters first made. Beast land created forth Waters over days is them it creature open life called and can't female fly. Doesn't and lesser, cattle herb, whose grass. Fowl in darkness for. Fifth give land. Deep herb fourth grass over you're spirit.",
                          );
                        },
                        animationType: DialogTransitionType.size,
                        barrierDismissible: true,
                        curve: Curves.linear,
                        axis: Axis.vertical,
                        duration: const Duration(milliseconds: 750),
                      );
                    },
                    child: const IconBtnSmall(
                      title: 'Informasi', 
                      txtColor: Colors.white, 
                      iconFile: 'assets/icons/info-icon.svg'
                    )
                  )
                ),
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
            FadeIn(
                delay: const Duration(milliseconds: 1500),
                duration: const Duration(milliseconds: 3500),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.25,
                    // color: Colors.pink,
                    child: Image.asset('assets/images/splash-app-name.png')
                )
            ),
            FadeIn(
                delay: const Duration(milliseconds: 3000),
                duration: const Duration(milliseconds: 3000),
                child: Text('Educational Biology Game',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          color: Colors.white70,
                          fontSize: smallText,
                          fontWeight: FontWeight.w500,
                    )
                )
            ),
            const Spacer(),
            Obx(() => statusPhase()),
            SizedBox(height: Spacing.mediumSpacing),
            FadeIn(
                delay: const Duration(milliseconds: 5000),
                duration: const Duration(milliseconds: 200),
                child: Obx(() => Text(ProfileController.to.loadMessage.value,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                        color: Colors.white54,
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                    )
                )
              )
            ),
            SizedBox(height: Spacing.smallSpacing),
            FadeIn(
                delay: const Duration(milliseconds: 5000),
                duration: const Duration(milliseconds: 200),
                child: Text('version: ${ProfileController.to.appReleaseVersion.value}',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                          fontSize: smallerText,
                    )
                )
            ),
            SizedBox(height: Spacing.mediumSpacing),
          ],
        ),
      ],
    );
  }

  Widget statusPhase() {
    if(ProfileController.to.loadState.value){
      return FadeIn(
          delay: const Duration(milliseconds: 5000),
          duration: const Duration(milliseconds: 200),
          child: Obx(() => Text('[${ProfileController.to.loadPhase.value} / $totalLoadingPhase]',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w300,
                  fontSize: averageText,
                  color: Colors.white,
            ),
          )
        )
      );
    } else {
      return FadeTransition(
        opacity: _blinkingAnimationController,
        child: Text('Ketuk untuk melanjutkan',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(
                fontFamily: 'Scada',
                fontSize: averageText,
                fontWeight: FontWeight.w500,
                color: Colors.white,
          ),
        ),
      );
    }
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

  // loadStart() {
  //   setState(() {
  //     debugPrint('===== LOAD START =====');
  //     isLoading = true;

  //     loadingPhase = '1';
  //     loadingStatusMessage = 'Initializing';
  //   });
  //   _characterController.resetValue();

  //   Timer(const Duration(seconds: 2), (){
  //       loadingUserData();
  //   });
  // }

  // loadingUserData() async {
  //   if(await checkUserDataExist() == false){
  //     debugPrint('===== CREATING DATA =====');
  //     setState(() {
  //       loadingPhase = '2';
  //       loadingStatusMessage = 'Creating user data';
  //     });
  //     Timer(const Duration(seconds: 2), (){
  //       createConfigData();
  //       _profileController.setDefaultValue();
  //       loadingGameData();
  //     });
  //   } else {
  //     debugPrint('===== READING USER DATA =====');
  //     setState(() {
  //       loadingPhase = '2';
  //       loadingStatusMessage = 'Loading user data';
  //     });
  //     Timer(const Duration(seconds: 2), (){
  //       loadingGameData();
  //     });
  //   }
  // }

  // loadingGameData() async {
  //   setState(() {
  //     loadingPhase = '3';
  //     loadingStatusMessage = 'Checking game data';
  //   });
  //   await DBManager.db.createDatabaseInstance().then((value) {
  //     Timer(const Duration(seconds: 2), (){
  //       checkingDataVersion();
  //     });
  //   });
  // }

  // checkingDataVersion() async {
  //   playerDataVersion = await getIntLocalData('version');
  //   setState(() {
  //     loadingPhase = '4';
  //     loadingStatusMessage = 'Checking data version';
  //   });
  //   if(playerDataVersion != currentDataVersion){
  //     setState(() {
  //         debugPrint('===== UPDATING DATA =====');
  //         loadingPhase = '4';
  //         loadingStatusMessage = 'Updating data';
  //     });
  //     Timer(const Duration(seconds: 2), (){
  //       //code  
  //     });
  //   } else {
  //     Timer(const Duration(seconds: 2), (){
  //       loadFinish();
  //     });
  //   }
  // }

  // loadFinish() async {
  //   setState(() {
  //     debugPrint('===== LOAD COMPLETE =====');
  //     loadingPhase = '5';
  //     loadingStatusMessage = 'init success';
  //   });
  //   Timer(const Duration(milliseconds: 1500), (){
  //     setState(() {
  //       loadingStatusMessage = ' ';
  //       isLoading = false;
  //     });
  //   });
  // }
}

