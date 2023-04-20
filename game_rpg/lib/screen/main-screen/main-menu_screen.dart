// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/shop-controller.dart';
import 'package:game_rpg/getx/profile-controller.dart';
import 'package:game_rpg/widgets/confirm-dialog/dialog-core.dart';
import 'package:game_rpg/widgets/glass-button.dart';
import 'package:game_rpg/widgets/small-icon-btn.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lottie/lottie.dart';

class MainMenuScreen extends StatefulWidget{
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>{
  bool continueGame = false;
  bool isLoading = false;

  late Image imageBG;
  String coin = '';

  startMainMenuSystem() async {
    setState(() {
      isLoading = true;
      continueGame = ProfileController.to.continueGameStatus.value;
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  startNewGame() async {
    if(continueGame){
      var newGame = false;
      newGame = await newGameDialog(context);
      return newGame;
    }
  }

  @override
  void initState() {
    imageBG = Image.asset('assets/images/background/main-screen-bg.png');
    startMainMenuSystem();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(imageBG.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var userExit = false;
        userExit = await exitDialoguePopup(context);
        return userExit;
      },
      child: Scaffold(
        body: SafeArea(
          child: mainContent(),
        )
      )
    );
  }

  Widget mainContent() {
    if(!isLoading){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: plainBlackBackground,
          image: DecorationImage(
            image: AssetImage('assets/images/background/main-screen-bg.png'),
            fit: BoxFit.fill
          )
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.pinkAccent,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        top: 10,
                        child: GlassContainer(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.1,
                          blur: 3,
                          border: Border.all(color: glassWhiteBorder, width: 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: Spacing.smallSpacing),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.075,
                                  height: MediaQuery.of(context).size.width * 0.075,
                                  child: SvgPicture.asset('assets/icons/gold-coin-icon.svg', fit: BoxFit.fill,),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Center(
                                  child: Obx(() => Text(ShopController.to.formatCoins(),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        fontSize: smallText,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white
                                      ),
                                  ))
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                      Column(
                        children: [
                          SizedBox(height: Spacing.largeSpacing * 3),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.width * 0.25,
                              // color: Colors.blueGrey,
                              child: Image.asset('assets/images/bios-logo-mainscreen.png'),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        // color: Colors.yellow,
                        padding: EdgeInsets.all(Spacing.smallSpacing),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const IconBtnSmall(
                                title: 'Pengaturan', 
                                txtColor: Colors.white, 
                                iconFile: 'assets/icons/setting-icon.svg'
                              ),
                            ),
                            // SizedBox(height: Spacing.smallSpacing),
                            SizedBox(height: Spacing.smallSpacing),
                            GestureDetector(
                              onTap: () {},
                              child: const IconBtnSmall(
                                title: 'Cara Bermain', 
                                txtColor: Colors.white, 
                                iconFile: 'assets/icons/help-icon.svg'
                              ),
                            ),
                            SizedBox(height: Spacing.smallSpacing),
                            GestureDetector(
                              onTap: () {},
                              child: const IconBtnSmall(
                                title: 'Toko', 
                                txtColor: Colors.white, 
                                iconFile: 'assets/icons/shop-icon.svg'
                              ),
                            ),
                          ],
                        ),
                      ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                GlassButton(
                  title: 'Mulai Permainan Baru', 
                  subTitle: (continueGame) ? 'Permainan yang dimainkan sebelumnya akan hilang jika memulai permainan baru' : 'Mainkan permainan, jawab pertanyaan, dan kalahkan musuh', 
                  iconFile: 'sword-home-icon', 
                  onPress: () async {
                    debugPrint('New Game Pressed');
                    
                    if(continueGame){
                      var newGame = false;
                      newGame = await newGameDialog(context);
                      if(newGame){
                        ProfileController.to.setContinueGameStatus(gameStatus: false);
                      }
                    }else{
                      Navigator.pushNamed(context, 'characterSelectScreen');
                    }
                  }, 
                  redSubtitle: continueGame,
                ),
                SizedBox(height: Spacing.mediumSpacing),
                if(continueGame)
                  GlassButton(
                    title: 'Lanjutkan Permainan', 
                    subTitle: 'Melanjutkan permainan dari titik terakhir dimainkan', 
                    iconFile: 'flag-icon', 
                    onPress: () {
                      debugPrint('Continue Game Pressed');
                    }, 
                  ),
                if(continueGame)
                  SizedBox(height: Spacing.mediumSpacing),
                GlassButton(
                  title: 'Pelajari Materi', 
                  subTitle: 'Pelajari tentang materi dan tentang apa yang akan muncul sebagai pertanyaan', 
                  iconFile: 'book-icon', 
                  onPress: () {
                    debugPrint('Learn Subject Pressed');
                  }, 
                ),
                SizedBox(height: Spacing.mediumSpacing),
                GlassButton(
                  title: 'Karakter', 
                  subTitle: 'Lihat semua karakter serta kemampuan mereka', 
                  iconFile: 'valk-icon', 
                  onPress: () {
                    debugPrint('Character Menu Pressed');

                    Navigator.pushNamed(context, 'characterPageScreen');
                  }, 
                ),
                SizedBox(height: Spacing.mediumSpacing),
                GlassButton(
                  title: 'Keluar dari Permainan',
                  subtitleOn: false, 
                  subTitle: '', 
                  iconFile: 'exit-off-icon', 
                  onPress: () async {
                    debugPrint('Exit Pressed');

                    var userExit = false;
                    userExit = await exitDialoguePopup(context);
                    if(userExit){
                      SystemNavigator.pop();
                    }
                  }, 
                  btnColor: glassRedColor,
                  btnBorderColor: glassRedBorder,
                ),
                const Spacer(flex: 2),
              ],
            )
          ],
        ),
      );
    } else {
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