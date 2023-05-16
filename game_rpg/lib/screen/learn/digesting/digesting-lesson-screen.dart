// ignore_for_file: file_names

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/screen/learn/digesting/about-digesting-page.dart';
import 'package:game_rpg/screen/learn/digesting/digesting-disease-page.dart';
import 'package:game_rpg/screen/learn/digesting/digesting-organs-page.dart';
import 'package:game_rpg/screen/learn/digesting/digesting-process-page.dart';
import 'package:game_rpg/widgets/custom-menu-btn.dart';
import 'package:lottie/lottie.dart';

class DigestingLessonScreen extends StatefulWidget{
  const DigestingLessonScreen({super.key});

  @override
  State<DigestingLessonScreen> createState() => _DigestingLessonScreenState();
}

class _DigestingLessonScreenState extends State<DigestingLessonScreen> {
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
    if(!isLoading){
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
                      child: Text('Sistem Pencernaan',
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
                      child: Text('Sistem Pencernaan',
                        style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w800,
                            fontSize: largeText,
                            color: Colors.black
                          ),
                      ),
                    ),
                    SizedBox(height: Spacing.mediumSpacing),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Image.asset('assets/images/material/pencernaan-main-model.jpg', fit: BoxFit.fill,),
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
                          title: 'Urutan Organ', 
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
                    SizedBox(height: Spacing.smallSpacing),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomMenuBtn(
                          title: 'Proses Pencernaan', 
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
                          title: 'Gangguan Sistem Pencernaan', 
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
                    SizedBox(height: Spacing.smallSpacing),
                    pageView()
                  ],
                ),
              )
            )
          ]
        )
      );
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

  Widget pageView(){
    if(menu1){
      return const AboutDigestingPage();
    }else if(menu2){
      return const DigestingOrgansPage();
    }else if(menu3){
      return const DigestingProcessPage();
    }else{
      return const DigestingDiseasePage();
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