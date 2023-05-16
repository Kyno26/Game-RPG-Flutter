// ignore_for_file: file_names

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:lottie/lottie.dart';

class LessonMainMenu extends StatefulWidget{
  const LessonMainMenu({super.key});

  @override
  State<LessonMainMenu> createState() => _LessonMainMenuState();
}

class _LessonMainMenuState extends State<LessonMainMenu> {
  late Image imageBG;
  bool isLoading = true;

  @override
  void initState() {
    imageBG = Image.asset('assets/images/background/tableBG.jpg');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        child: mainContent(),
      )
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
                      child: Text('Pilih Materi',
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
            const Spacer(),
            // Center(
            //   child: Container(
            //     width: MediaQuery.of(context).size.width * 0.7,
            //     child: Text('Pilih materi yang ingin anda pelajari dari pilihan materi dibawah ini',
            //       textAlign: TextAlign.center,
            //       style: Theme.of(context)
            //         .textTheme
            //         .headline6!
            //         .copyWith(
            //           fontFamily: 'Scada',
            //           fontWeight: FontWeight.w800,
            //           fontSize: averageText,
            //           color: Colors.black87
            //         ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: Spacing.mediumSpacing * 2,),
            lessonBtn(
              text: 'Pernapasan', 
              navigateTo: 'respirationLesson', 
              image: 'assets/images/background/sistem-pernapasan-BG.png'
            ),
            SizedBox(height: Spacing.mediumSpacing),
            lessonBtn(
              text: 'Pencernaan', 
              navigateTo: 'digestingLesson', 
              image: 'assets/images/background/sistem-pencernaan-BG.png'
            ),
            SizedBox(height: Spacing.mediumSpacing),
            lessonBtn(
              text: 'Pertahanan Tubuh', 
              navigateTo: 'immuneSystemLesson', 
              image: 'assets/images/background/sistem-pertahanan-BG.png'
            ),
            const Spacer(),
          ],
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

  Widget lessonBtn({required String text, required String navigateTo, required String image}){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, navigateTo);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400, width: 2),
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.fill
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(left: Spacing.mediumSpacing, top: Spacing.mediumSpacing, bottom: Spacing.mediumSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sistem',
                style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: averageText,
                    color: Colors.black
                  ),
              ),
              SizedBox(height: Spacing.smallSpacing),
              Text(text,
                style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: averageText,
                    color: Colors.black
                  ),
              ),
            ],
          )
        ),
      )
    );
  }
}