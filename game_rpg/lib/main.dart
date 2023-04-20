import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/enemy-controller.dart';
import 'package:game_rpg/getx/special-dialog-controller.dart';
import 'package:game_rpg/getx/profile-controller.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:game_rpg/getx/shop-controller.dart';
import 'package:game_rpg/screen/battle/battlefield.dart';
import 'package:game_rpg/screen/main-screen/character-info_screen.dart';
import 'package:game_rpg/screen/main-screen/character-page_screen.dart';
import 'package:game_rpg/screen/main-screen/character-select_screen.dart';
import 'package:game_rpg/screen/main-screen/main-menu_screen.dart';
import 'package:game_rpg/screen/main-screen/splash_screen.dart';
import 'package:game_rpg/screen/main-screen/start_screen.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    Get.put(CharacterController());
    Get.put(ProfileController());
    Get.put(ShopController());
    Get.put(BattleFieldController());
    Get.put(EnemyController());
    Get.put(QuestionController());
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [SystemUiOverlay.bottom]);
  // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  runApp(
      NeumorphicApp(
        title: 'BIOS',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        home: const SplashSreen(),
        onGenerateRoute: (screen) {
          switch (screen.name) {
            case 'splashScreen':
              return PageTransition(child: const SplashSreen(), type: PageTransitionType.fade);
            case 'startScreen':
              return PageTransition(child: const StartScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 500));
            case 'mainMenuScreen':
              return PageTransition(child: const MainMenuScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 500), 
                settings: const RouteSettings(name: 'mainMenuScreen'));
            case 'characterSelectScreen':
              return PageTransition(child: const CharacterSelectScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 100));
            case 'characterPageScreen':
              return PageTransition(child: const CharacterPageScreen(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 100));
            case 'characterInfoScreen':
              return PageTransition(child: CharacterInfoScreen(id: CharacterController.to.selectedCharacterId.value), type: PageTransitionType.fade, duration: const Duration(milliseconds: 100));
            case 'battlefield':
              return PageTransition(child: const BattleField(), type: PageTransitionType.fade, duration: const Duration(milliseconds: 500));
            default:
              return null;
          }
        },
      )
  );

  });
}