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
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
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
                        color: Colors.black26,
                      )
                    ),
                    GestureDetector(
                      onTap: () {
                        if (page != 3) {
                          setState(() {
                            page++;
                          });
                          print(page);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        color: Colors.black26,
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
    }else{
      return Column();
    }
  }
}