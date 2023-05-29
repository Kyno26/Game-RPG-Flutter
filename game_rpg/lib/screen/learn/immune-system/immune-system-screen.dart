// ignore_for_file: file_names

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/immune-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/screen/learn/immune-system/about-immune-system-page.dart';
import 'package:game_rpg/screen/learn/immune-system/immune-disease-page.dart';
import 'package:game_rpg/screen/learn/immune-system/immune-nonspecific-page.dart';
import 'package:game_rpg/screen/learn/immune-system/immune-specific-page.dart';
import 'package:game_rpg/widgets/custom-menu-btn.dart';
import 'package:game_rpg/widgets/text-content-lesson.dart';
import 'package:lottie/lottie.dart';

class ImmuneSystemScreen extends StatefulWidget{
  const ImmuneSystemScreen({super.key});

  @override
  State<ImmuneSystemScreen> createState() => _ImmuneSystemScreenState();
}

class _ImmuneSystemScreenState extends State<ImmuneSystemScreen> {
  late Image imageBG;
  bool isLoading = true;

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
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Center(
                      child: Text('Sistem Pertahanan Tubuh',
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
                      child: Text('Sistem Pertahanan Tubuh',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomMenuBtn(
                          title: 'Tentang', 
                          onPress: (){
                            setState(() {
                              menu1 = true;
                              menu2 = false;
                              menu3 = false;
                              menu4 = false;
                            });
                          }, 
                          menuOpt: menu1
                        ),
                        CustomMenuBtn(
                          title: 'Pertahanan Tubuh Nonspesifik', 
                          onPress: (){
                            setState(() {
                              menu1 = false;
                              menu2 = true;
                              menu3 = false;
                              menu4 = false;
                            });
                          }, 
                          menuOpt: menu2
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomMenuBtn(
                          title: 'Pertahanan Tubuh Spesifik', 
                          onPress: (){
                            setState(() {
                              menu1 = false;
                              menu2 = false;
                              menu3 = true;
                              menu4 = false;
                            });
                          }, 
                          menuOpt: menu3
                        ),
                        CustomMenuBtn(
                          title: 'Gangguan Sistem Pertahanan Tubuh', 
                          onPress: (){
                            setState(() {
                              menu1 = false;
                              menu2 = false;
                              menu3 = false;
                              menu4 = true;
                            });
                          }, 
                          menuOpt: menu4
                        ),
                      ],
                    ),
                    SizedBox(height: Spacing.mediumSpacing),
                    pageView(),
                  ],
                ),
              )
            )
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
      return const AboutImmuneSystemPage();
    }else if(menu2){
      return const ImmuneNonSpecificPage();
    }else if(menu3){
      return const ImmuneSpecificPage();
    }else{
      return const ImmuneDiseasePage();
    }
  }
}