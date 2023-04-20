// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/model/character.dart';
import 'package:game_rpg/widgets/character-box.dart';
import 'package:lottie/lottie.dart';

class CharacterPageScreen extends StatefulWidget{
  const CharacterPageScreen({super.key});

  @override
  State<CharacterPageScreen> createState() => _CharacterPageScreenState();
}

class _CharacterPageScreenState extends State<CharacterPageScreen>{
  bool isLoading = true;
  Future<List<Character>>? characterList;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    setState(() {
      isLoading = true;
    });
    characterList = DBManager.db.getAllCharacter();
    setState(() {
      isLoading = false;
    });
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
            width: MediaQuery.of(context).size.width,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Center(
                    child: Text('Daftar Karakter',
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
          SizedBox(height: Spacing.smallSpacing),
          Expanded(
            child: FutureBuilder<List<Character>>(
              future: characterList,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List<Character> characterListData = snapshot.data!;
                  return Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      ...characterListData.map((character) {
                        return CharacterBox(character: character);
                      })
                    ],
                  );
                }else{
                  return const Center(
                    child: Text('Loading...'),
                  );
                }
              },
            )
          )
        ],
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