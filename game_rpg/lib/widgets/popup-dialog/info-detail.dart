// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class InfoDetail extends StatefulWidget{
  const InfoDetail({super.key});

  @override
  State<InfoDetail> createState() => _InfoDetailState();
}

class _InfoDetailState extends State<InfoDetail>{

  int page = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassContainer(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: glassWhiteBorder, width: 2),
        color: Colors.white30,
        blur: 3,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: detailPage(),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                // color: Colors.pink,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (page != 1) {
                          setState(() {
                            page--;
                          });
                          print(page);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        color: (page == 1) ? Colors.black26 : Colors.green,
                        child: const Icon(Icons.arrow_left, color: Colors.white70),
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        if (page != 2) {
                          setState(() {
                            page++;
                          });
                          print(page);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        color: (page == 2) ? Colors.black26 : Colors.green,
                        child: const Icon(Icons.arrow_right, color: Colors.white70),
                      )
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: Spacing.smallSpacing),
          ],
        ),
      ),
    );
  }

  Widget detailPage() {
    if(page == 1){
      return Column(
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.mediumSpacing),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade100,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1),
                    image: DecorationImage(
                      image: AssetImage(CharacterController.to.playerCharacterImage.value)
                    )
                  ),
                ),
                SizedBox(width: Spacing.mediumSpacing),
                Text(CharacterController.to.playerName.value,
                  style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(
                      fontFamily: 'Scada',
                      fontSize: averageText,
                      fontWeight: FontWeight.w700,
                      color: plainBlackBackground
                    ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: Spacing.mediumSpacing),
              child: Text('Info Status',
                style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: largeText,
                    color: Colors.white
                  ),
              ),
            )
          ),
          SizedBox(height: Spacing.smallSpacing),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: Spacing.mediumSpacing),
            // color: Colors.deepPurple.shade100,
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(()=> Text('${CharacterController.to.playerHealth.value} / ${CharacterController.to.playerMaxHealth.value}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(()=> Text('${CharacterController.to.playerAtk.value}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(()=> Text('${CharacterController.to.playerDef.value}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(()=> Text('${CharacterController.to.playerSpd.value}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(()=> Text('${CharacterController.to.playerAcc.value}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(()=> Text('${CharacterController.to.playerCrit.value}%',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
                      ),
                    ),),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }else if(page == 2){
      return Column(
        children: [
          SizedBox(height: Spacing.mediumSpacing * 2),
          Center(
            child: Text('Upgrade Status',
              style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w700,
                  fontSize: largeText,
                  color: Colors.white
                ),
            ),
          ),
          SizedBox(height: Spacing.mediumSpacing),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: Spacing.mediumSpacing),
              child: Obx(() => Text('Poin Upgrade tersisa: ${CharacterController.to.upgradePointAvailable.value}',
                style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w400,
                    fontSize: smallText,
                    color: Colors.white
                  ),
              ),)
            )
          ),
          SizedBox(height: Spacing.smallSpacing),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.symmetric(horizontal: Spacing.mediumSpacing),
            // color: Colors.deepPurple.shade100,
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() =>SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.curPlayerMaxHealth.value != CharacterController.to.basePlayerMaxHealth.value){
                                CharacterController.to.curPlayerMaxHealth.value--;
                                CharacterController.to.upgradePointAvailable.value++;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: (CharacterController.to.curPlayerMaxHealth.value == CharacterController.to.basePlayerMaxHealth.value) ? Colors.grey.shade400 : Colors.white,
                              child: const Icon(Icons.remove, color: Colors.black87,),
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          Text('${CharacterController.to.curPlayerMaxHealth.value}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  fontFamily: 'Scada',
                                  fontWeight: FontWeight.w400,
                                  fontSize: smallText,
                                  color: Colors.white
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.upgradePointAvailable.value != 0){
                                CharacterController.to.curPlayerMaxHealth.value++;
                                CharacterController.to.upgradePointAvailable.value--;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: Colors.white,
                              child: const Icon(Icons.add, color: Colors.black87,),
                            ),
                          ),
                        ],
                      ),
                    ))
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() =>SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.curPlayerAtk.value != CharacterController.to.basePlayerAtk.value){
                                CharacterController.to.curPlayerAtk.value--;
                                CharacterController.to.upgradePointAvailable.value++;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: (CharacterController.to.curPlayerAtk.value == CharacterController.to.basePlayerAtk.value) ? Colors.grey.shade400 : Colors.white,
                              child: const Icon(Icons.remove, color: Colors.black87,),
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          Text('${CharacterController.to.curPlayerAtk.value}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  fontFamily: 'Scada',
                                  fontWeight: FontWeight.w400,
                                  fontSize: smallText,
                                  color: Colors.white
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.upgradePointAvailable.value != 0){
                                CharacterController.to.curPlayerAtk.value++;
                                CharacterController.to.upgradePointAvailable.value--;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: Colors.white,
                              child: const Icon(Icons.add, color: Colors.black87,),
                            ),
                          ),
                        ],
                      ),
                    ))
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() =>SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.curPlayerDef.value != CharacterController.to.basePlayerDef.value){
                                CharacterController.to.curPlayerDef.value--;
                                CharacterController.to.upgradePointAvailable.value++;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: (CharacterController.to.curPlayerDef.value == CharacterController.to.basePlayerDef.value) ? Colors.grey.shade400 : Colors.white,
                              child: const Icon(Icons.remove, color: Colors.black87,),
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          Text('${CharacterController.to.curPlayerDef.value}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  fontFamily: 'Scada',
                                  fontWeight: FontWeight.w400,
                                  fontSize: smallText,
                                  color: Colors.white
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.upgradePointAvailable.value != 0){
                                CharacterController.to.curPlayerDef.value++;
                                CharacterController.to.upgradePointAvailable.value--;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: Colors.white,
                              child: const Icon(Icons.add, color: Colors.black87,),
                            ),
                          ),
                        ],
                      ),
                    ))
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() =>SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.curPlayerSpd.value != CharacterController.to.basePlayerSpd.value){
                                CharacterController.to.curPlayerSpd.value--;
                                CharacterController.to.upgradePointAvailable.value++;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: (CharacterController.to.curPlayerSpd.value == CharacterController.to.basePlayerSpd.value) ? Colors.grey.shade400 : Colors.white,
                              child: const Icon(Icons.remove, color: Colors.black87,),
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          Text('${CharacterController.to.curPlayerSpd.value}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  fontFamily: 'Scada',
                                  fontWeight: FontWeight.w400,
                                  fontSize: smallText,
                                  color: Colors.white
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.upgradePointAvailable.value != 0){
                                CharacterController.to.curPlayerSpd.value++;
                                CharacterController.to.upgradePointAvailable.value--;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: Colors.white,
                              child: const Icon(Icons.add, color: Colors.black87,),
                            ),
                          ),
                        ],
                      ),
                    ))
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() =>SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.curPlayerAcc.value != CharacterController.to.basePlayerAcc.value){
                                CharacterController.to.curPlayerAcc.value--;
                                CharacterController.to.upgradePointAvailable.value++;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: (CharacterController.to.curPlayerAcc.value == CharacterController.to.basePlayerAcc.value) ? Colors.grey.shade400 : Colors.white,
                              child: const Icon(Icons.remove, color: Colors.black87,),
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          Text('${CharacterController.to.curPlayerAcc.value}',
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                  fontFamily: 'Scada',
                                  fontWeight: FontWeight.w400,
                                  fontSize: smallText,
                                  color: Colors.white
                            ),
                          ),
                          SizedBox(width: Spacing.smallSpacing),
                          GestureDetector(
                            onTap: (){
                              if(CharacterController.to.upgradePointAvailable.value != 0){
                                CharacterController.to.curPlayerAcc.value++;
                                CharacterController.to.upgradePointAvailable.value--;
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.075,
                              height: MediaQuery.of(context).size.width * 0.075,
                              color: Colors.white,
                              child: const Icon(Icons.add, color: Colors.black87,),
                            ),
                          ),
                        ],
                      ),
                    ))
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
                                color: Colors.white
                              ),
                          ),
                        ],
                      ),
                    ),
                    Obx(()=> Text('${CharacterController.to.basePlayerCrit.value}%',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
                      ),
                    ),),
                  ],
                ),
                SizedBox(height: Spacing.mediumSpacing),
                Center(
                  child: Obx(() => ElevatedButton(
                    onPressed: (){
                      if(CharacterController.to.upgradePointAvailable.value != CharacterController.to.upgradePointOwned.value){
                        CharacterController.to.upgradePlayerStatus();
                      }
                    }, 
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing, horizontal: Spacing.mediumSpacing),
                      backgroundColor: (CharacterController.to.upgradePointAvailable.value == CharacterController.to.upgradePointOwned.value) ? Colors.grey : Colors.green,
                    ),
                    child: Text('Tingkatkan',
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontWeight: FontWeight.w600,
                          fontSize: smallText,
                          color: (CharacterController.to.upgradePointAvailable.value == CharacterController.to.upgradePointOwned.value) ? Colors.black : Colors.white
                        ),
                    )
                  )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing),
                    child: Text('Setelah ditingkatkan, status tidak dapat dikembalikan seperti semula. Harap tingkatkan dengan hati-hati.',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontWeight: FontWeight.w400,
                          fontSize: smallText,
                          color: Colors.yellow.shade600
                        ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }else{
      return Column();
    }
  }

  Widget upgradeBox({required int basePoint, required int curPoint, required String point}){
    return Obx(() =>SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: (){
              if(curPoint != basePoint){
                curPoint--;
                debugPrint('Current Point: $curPoint');
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.075,
              height: MediaQuery.of(context).size.width * 0.075,
              color: Colors.white,
              child: const Icon(Icons.remove, color: Colors.black87,),
            ),
          ),
          SizedBox(width: Spacing.smallSpacing),
          Text(point,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w400,
                  fontSize: smallText,
                  color: Colors.white
            ),
          ),
          SizedBox(width: Spacing.smallSpacing),
          GestureDetector(
            onTap: (){
              if(CharacterController.to.upgradePointAvailable.value != 0){
                curPoint++;
                debugPrint('Current Point: $curPoint');
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.075,
              height: MediaQuery.of(context).size.width * 0.075,
              color: Colors.white,
              child: const Icon(Icons.add, color: Colors.black87,),
            ),
          ),
        ],
      ),
    ));
  }
}