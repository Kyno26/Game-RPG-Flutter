// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/enemy-controller.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class EnemyStatDetail extends StatefulWidget{
  const EnemyStatDetail({super.key});

  @override
  State<EnemyStatDetail> createState() => _EnemyStatDetailState();
}

class _EnemyStatDetailState extends State<EnemyStatDetail> {

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
                child: Column(
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
                                image: AssetImage(EnemyController.to.enemyImage.value)
                              )
                            ),
                          ),
                          SizedBox(width: Spacing.mediumSpacing),
                          Text(EnemyController.to.enemyName.value,
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
                              Obx(()=> Text('${EnemyController.to.enemyHealth.value} / ${EnemyController.to.enemyMaxHealth.value}',
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
                              Obx(()=> Text('${EnemyController.to.enemyAtk.value}',
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
                              Obx(()=> Text('${EnemyController.to.enemyDef.value}',
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
                              Obx(()=> Text('${EnemyController.to.enemySpd.value}',
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
                              Obx(()=> Text('${EnemyController.to.enemyAcc.value}',
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
                              Obx(()=> Text('${EnemyController.to.enemyCrit.value}%',
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
                ),
              ),
            ),
            SizedBox(height: Spacing.smallSpacing),
          ],
        ),
      ),
    );
  }
}