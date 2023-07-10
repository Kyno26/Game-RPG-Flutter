// ignore_for_file: file_names

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/screen/learn/respiration/about-respiration-page.dart';
import 'package:game_rpg/screen/learn/respiration/respiration-disease-page.dart';
import 'package:game_rpg/screen/learn/respiration/respiration-organs-page.dart';
import 'package:game_rpg/screen/learn/respiration/respiration-process-page.dart';
import 'package:lottie/lottie.dart';

class RespirationLessonScreen extends StatefulWidget{
  const RespirationLessonScreen({super.key});

  @override
  State<RespirationLessonScreen> createState() => _RespirationLessonScreenState();
}

class _RespirationLessonScreenState extends State<RespirationLessonScreen> {
  late Image imageBG;
  bool isLoading = true;

  String onClick = '1';

  bool menu1 = true;
  bool menu2 = false;
  bool menu3 = false;
  bool menu4 = false;

  @override
  void initState() {
    imageBG = Image.asset('assets/images/background/tableBG.jpg');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(imageBG.image, context);
    Timer(const Duration(seconds: 1), (){
      setState(() {
        isLoading = false;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: mainContent()
      ),
    );
  }

  Widget mainContent(){
    if (!isLoading) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: plainBlackBackground,
          image: DecorationImage(
            image: AssetImage('assets/images/background/tableBG.jpg'),
            fit: BoxFit.fill
          )
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: softWhiteColor, width: 2)),
                color: Colors.brown
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      decoration: const BoxDecoration(
                        border: Border(right: BorderSide(color: softWhiteColor, width: 2))
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded, color: softWhiteColor),
                    ),
                  ),
                  SizedBox(
                    width: (BattleFieldController.to.inGame.value) ? MediaQuery.of(context).size.width * 0.85 : MediaQuery.of(context).size.width * 0.7,
                    child: Center(
                      child: Text('Sistem Pernapasan',
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontSize: averageText,
                            fontWeight: FontWeight.w700,
                            color: softWhiteColor
                          ),
                      ),
                    ),
                  ),
                  if(!BattleFieldController.to.inGame.value)
                  GestureDetector(
                    onTap: () {
                      Navigator.popUntil(context, ModalRoute.withName('mainMenuScreen'));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: softWhiteColor, width: 2))
                      ),
                      child: const Icon(Icons.home, color: softWhiteColor),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: Spacing.mediumSpacing),
                    Center(
                      child: Text('Sistem Pernapasan',
                        style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w800,
                            fontSize: largeText,
                            color: Colors.white
                          ),
                      ),
                    ),
                    SizedBox(height: Spacing.mediumSpacing),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Image.asset('assets/images/material/pernapasan-main-model.jpg', fit: BoxFit.fill,),
                      ),
                    ),
                    SizedBox(height: Spacing.mediumSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customBtn(
                          title: 'Tentang', 
                          // clicked: onClick, 
                          index: '1',
                          onPress: (){
                            setState(() {
                              menu1 = true;
                              menu2 = false;
                              menu3 = false;
                              menu4 = false;
                            });
                          },
                          menuOpt: menu1,
                          ),
                        customBtn(
                          title: 'Organ-Organ', 
                          // clicked: onClick, 
                          index: '2',
                          onPress: (){
                            setState(() {
                              menu1 = false;
                              menu2 = true;
                              menu3 = false;
                              menu4 = false;
                            });
                          },
                          menuOpt: menu2,
                          ),
                      ],
                    ),
                    SizedBox(height: Spacing.smallSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        customBtn(
                          title: 'Proses Respirasi', 
                          // clicked: onClick, 
                          index: '3',
                          onPress: (){
                            setState(() {
                              menu1 = false;
                              menu2 = false;
                              menu3 = true;
                              menu4 = false;
                            });
                          },
                          menuOpt: menu3,
                          ),
                        customBtn(
                          title: 'Gangguan Sistem Pernapasan', 
                          // clicked: onClick, 
                          index: '4',
                          onPress: (){
                            setState(() {
                              menu1 = false;
                              menu2 = false;
                              menu3 = false;
                              menu4 = true;
                            });
                          },
                          menuOpt: menu4,
                          ),
                      ],
                    ),
                    SizedBox(height: Spacing.smallSpacing),
                    pageView(),
                  ],
                ),
              )
            ),
          ]
        )
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
  
  Widget pageView(){
    if(menu1){
      return const AboutRespirationPage();
    }else if(menu2){
      return const RespirationOrganPage();
    }else if(menu3){
      return const RespirationProcessPage();
    }else{
      return const RespirationDiseasePage();
    }
  }

  Widget customBtn({
    required String title, 
    required String index, 
    required Function() onPress,
    required bool menuOpt,
    }) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing, horizontal: Spacing.smallSpacing),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: menuOpt ? Colors.green : Colors.white,
          borderRadius: BorderRadiusDirectional.circular(5)
        ),
        child: Center(
          child: Text(title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(
                fontFamily: 'Scada',
                fontWeight: FontWeight.w600,
                fontSize: smallText,
                color: menuOpt ? Colors.white : Colors.black
              ),
          ),
        ),
      ),
    );
  }
}