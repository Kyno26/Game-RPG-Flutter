// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/model/character.dart';
import 'package:game_rpg/widgets/select-character-box.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CharacterSelectScreen extends StatefulWidget{
  const CharacterSelectScreen({super.key});

  @override
  State<CharacterSelectScreen> createState() => _CharacterSelectScreenState();
}

class _CharacterSelectScreenState extends State<CharacterSelectScreen> {
  bool isScreenLoading = true;
  Future<List<Character>>? characterList;

  late Image imagePaper1;
  late Image imagePaper2;

  @override
  void initState() {
    imagePaper1 = Image.asset('assets/images/background/paper-texture.jpg');
    imagePaper2 = Image.asset('assets/images/background/paper-texture-blur.png');
    loadCharacterList();
    super.initState();
  }
  
  @override
  void didChangeDependencies() {
    precacheImage(imagePaper1.image, context);
    precacheImage(imagePaper2.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    CharacterController.to.resetValue();
    super.dispose();
  }

  loadCharacterList() async {
    setState(() {
      isScreenLoading = true;
    });
    CharacterController.to.resetValue();
    characterList = DBManager.db.getAllCharacter();
    setState(() {
      isScreenLoading = false;
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
    if(!isScreenLoading){
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
                    child: Text('Pilih Karakter',
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
          Obx(() => (CharacterController.to.selected.value)
          ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.symmetric(horizontal: Spacing.smallSpacing),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: softWhiteColor, width: 1)),
              image: DecorationImage(
                image: AssetImage('assets/images/background/paper-texture.jpg'),
                fit: BoxFit.fill
              )
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: const BoxDecoration(
                    border: Border.symmetric(vertical: BorderSide(color: Colors.white54, width: 1))
                  ),
                  // color: Colors.lightBlue,
                  child: Image.asset(CharacterController.to.selectedCharacterImage.value, fit: BoxFit.fitHeight,),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: Spacing.smallSpacing),
                      Obx(()=> Text('Nama: ${CharacterController.to.selectedCharacterName.value.toString()}',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(
                              fontFamily: 'Scada',
                              fontWeight: FontWeight.w700,
                              fontSize: smallText,
                              color: Colors.black87
                          ),
                      ),),
                      // Obx(()=> Text('Peran: ${CharacterController.to.selectedCharacterJob.value.toString()}',
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .headline6!
                      //       .copyWith(
                      //         fontFamily: 'Scada',
                      //         fontWeight: FontWeight.w400,
                      //         fontSize: smallText,
                      //         color: Colors.black87
                      //     ),
                      // ),),
                      SizedBox(height: Spacing.smallSpacing),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.325,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.05,
                                        height: MediaQuery.of(context).size.width * 0.05,
                                        child: SvgPicture.asset('assets/icons/heart-icon.svg', fit: BoxFit.fill),
                                      ),
                                      SizedBox(width: Spacing.miniSpacing),
                                      Text('Nyawa : ',
                                        style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontFamily: 'Scada',
                                            fontSize: smallText,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(()=> Text('${CharacterController.to.selectedCharacterHP.value} Poin',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        fontWeight: FontWeight.w400,
                                        fontSize: smallText,
                                        color: Colors.black87
                                  ),
                                ),),
                              ],
                            ),
                            SizedBox(height: Spacing.smallSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.325,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.05,
                                        height: MediaQuery.of(context).size.width * 0.05,
                                        child: SvgPicture.asset('assets/icons/sword-icon.svg', fit: BoxFit.fill),
                                      ),
                                      SizedBox(width: Spacing.miniSpacing),
                                      Text('Serangan : ',
                                        style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontFamily: 'Scada',
                                            fontSize: smallText,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(()=> Text('${CharacterController.to.selectedCharacterAttack.value} Poin',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        fontWeight: FontWeight.w400,
                                        fontSize: smallText,
                                        color: Colors.black87
                                  ),
                                ),),
                              ],
                            ),
                            SizedBox(height: Spacing.smallSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.325,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.05,
                                        height: MediaQuery.of(context).size.width * 0.05,
                                        child: SvgPicture.asset('assets/icons/shield-icon.svg', fit: BoxFit.fill),
                                      ),
                                      SizedBox(width: Spacing.miniSpacing),
                                      Text('Pertahanan : ',
                                        style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontFamily: 'Scada',
                                            fontSize: smallText,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(()=> Text('${CharacterController.to.selectedCharacterDefense.value} Poin',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        fontWeight: FontWeight.w400,
                                        fontSize: smallText,
                                        color: Colors.black87
                                  ),
                                ),),
                              ],
                            ),
                            SizedBox(height: Spacing.smallSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.325,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.05,
                                        height: MediaQuery.of(context).size.width * 0.05,
                                        child: SvgPicture.asset('assets/icons/speed-icon.svg', fit: BoxFit.fill),
                                      ),
                                      SizedBox(width: Spacing.miniSpacing),
                                      Text('Kecepatan : ',
                                        style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontFamily: 'Scada',
                                            fontSize: smallText,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(()=> Text('${CharacterController.to.selectedCharacterSpeed.value} Poin',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        fontWeight: FontWeight.w400,
                                        fontSize: smallText,
                                        color: Colors.black87
                                  ),
                                ),),
                              ],
                            ),
                            SizedBox(height: Spacing.smallSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.325,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.05,
                                        height: MediaQuery.of(context).size.width * 0.05,
                                        child: SvgPicture.asset('assets/icons/accuracy-icon.svg', fit: BoxFit.fill),
                                      ),
                                      SizedBox(width: Spacing.miniSpacing),
                                      Text('Akurasi : ',
                                        style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontFamily: 'Scada',
                                            fontSize: smallText,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(()=> Text('${CharacterController.to.selectedCharacterAccuracy.value} Poin',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        fontWeight: FontWeight.w400,
                                        fontSize: smallText,
                                        color: Colors.black87
                                  ),
                                ),),
                              ],
                            ),
                            SizedBox(height: Spacing.smallSpacing),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.325,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.05,
                                        height: MediaQuery.of(context).size.width * 0.05,
                                        child: SvgPicture.asset('assets/icons/critical-hit-icon.svg', fit: BoxFit.fill),
                                      ),
                                      SizedBox(width: Spacing.miniSpacing),
                                      Text('Kritikal : ',
                                        style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(
                                            fontFamily: 'Scada',
                                            fontSize: smallText,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87
                                          ),
                                      ),
                                    ],
                                  ),
                                ),
                                Obx(()=> Text('${CharacterController.to.selectedCharacterCritRate.value}%',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontFamily: 'Scada',
                                        fontWeight: FontWeight.w400,
                                        fontSize: smallText,
                                        color: Colors.black87
                                  ),
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          CharacterController.to.selectCharacter(
                            name: CharacterController.to.selectedCharacterName.value,
                            image: CharacterController.to.selectedCharacterPotraitImage.value, 
                            hp: CharacterController.to.selectedCharacterHP.value, 
                            atk: CharacterController.to.selectedCharacterAttack.value, 
                            def: CharacterController.to.selectedCharacterDefense.value, 
                            spd: CharacterController.to.selectedCharacterSpeed.value, 
                            acc: CharacterController.to.selectedCharacterAccuracy.value, 
                            crit: CharacterController.to.selectedCharacterCritRate.value
                          );
                          
                          BattleFieldController.to.resetBattlegroundData();
                          Navigator.pushReplacementNamed(context, 'battlefield');
                        },
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing, horizontal: Spacing.smallSpacing),
                            decoration: BoxDecoration(
                              color: Colors.brown.shade700,
                              border: Border.all(color: Colors.black54, width: 1),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text('Mulai',
                                style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontFamily: 'Scada',
                                    fontSize: smallText,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                  ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Spacing.mediumSpacing),
                    ],
                  ),
                ),
              ],
            ),
          )
          : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.symmetric(horizontal: Spacing.smallSpacing),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: softWhiteColor, width: 1)),
              image: DecorationImage(
                image: AssetImage('assets/images/background/paper-texture-blur.png'),
                fit: BoxFit.fill
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Pilih karakter yang ingin digunakan',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                      fontFamily: 'Scada',
                      fontSize: averageText,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                ),
                SizedBox(height: Spacing.smallSpacing),
                Text('(Karakter tidak dapat diganti sampai permainan berakhir)',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                      fontFamily: 'Scada',
                      fontSize: smallText,
                      fontWeight: FontWeight.w400,
                      color: Colors.yellow.shade500
                    ),
                ),
              ],
            )
          ),
          ),
          SizedBox(height: Spacing.smallSpacing),
          Expanded(
            child: FutureBuilder<List<Character>>(
              future: characterList,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  List<Character> characterListData = snapshot.data!;
                  return SingleChildScrollView(
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: [
                        ...characterListData.map((character) {
                          return SelectCharacterBox(character: character);
                        })
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 0.3,
                        //   height: MediaQuery.of(context).size.height * 0.225,
                        //   color: Colors.pink,
                        // )
                      ],
                    )
                  );
                }else{
                  return const Center(
                    child: Text('Error, Data Kosong'),
                  );
                }
              },
            )
          )
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