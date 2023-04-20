// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:lottie/lottie.dart';

class CharacterInfoScreen extends StatefulWidget{
  const CharacterInfoScreen({super.key, required this.id});

  final int id;

  @override
  State<CharacterInfoScreen> createState() => _CharacterInfoScreenState();
}

class _CharacterInfoScreenState extends State<CharacterInfoScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: plainBlackBackground,
      body: SafeArea(
        child: mainContent(),
      ),
    );
  }

  Widget mainContent() {
    if(!isLoading){
      return Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: softWhiteColor, width: 2)),
              color: plainBlackBackground
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
          SizedBox(height: Spacing.smallSpacing),
        ],
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
              child: Lottie.asset('assets/images/load-animation.json', 
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