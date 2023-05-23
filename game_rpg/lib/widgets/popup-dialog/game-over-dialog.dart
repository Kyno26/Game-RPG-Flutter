// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:game_rpg/getx/shop-controller.dart';

class GameOverDialog extends StatelessWidget{
  const GameOverDialog({super.key, required this.enemyDefeated, required this.score, required this.coinsEarned});

  final String enemyDefeated;
  final String score;
  final String coinsEarned;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.35,
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: Spacing.mediumSpacing),
                  Center(
                    child: Text('- - GAME OVER - -',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: redColor
                        ),
                    ),
                  ),
                  SizedBox(height: Spacing.mediumSpacing),
                  if(BattleFieldController.to.gameFinished.value)
                  Center(
                    child: Text('Permainan Selesai',
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontWeight: FontWeight.w400,
                          fontSize: smallText,
                          color: Colors.black
                        ),
                    ),
                  ),
                  Center(
                    child: RichText(
                      textDirection: TextDirection.ltr,
                      text: TextSpan(
                        text: 'Musuh dikalahkan: ',
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontSize: smallText,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        children: [
                          TextSpan(
                            text: enemyDefeated,
                            style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                fontFamily: 'Scada',
                                fontSize: smallText,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ), 
                          ),
                        ]
                      ),
                    ),
                  ),
                  Center(
                    child: RichText(
                      textDirection: TextDirection.ltr,
                      text: TextSpan(
                        text: 'Skor: ',
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontSize: smallText,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        children: [
                          TextSpan(
                            text: score,
                            style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                fontFamily: 'Scada',
                                fontSize: smallText,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ), 
                          ),
                          if(QuestionController.to.newScore.value)
                          TextSpan(
                            text: '  (Skor tinggi terbaru)',
                            style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                fontFamily: 'Scada',
                                fontSize: smallText,
                                fontWeight: FontWeight.w600,
                                color: redColor,
                              ), 
                          ),
                        ]
                      ),
                    ),
                  ),
                  // Center(
                  //   child: RichText(
                  //     textDirection: TextDirection.ltr,
                  //     text: TextSpan(
                  //       text: 'Koin dimiliki: ',
                  //       style: Theme.of(context)
                  //         .textTheme
                  //         .headline6!
                  //         .copyWith(
                  //           fontFamily: 'Scada',
                  //           fontSize: smallText,
                  //           fontWeight: FontWeight.w400,
                  //           color: Colors.black87,
                  //         ),
                  //       children: [
                  //         TextSpan(
                  //           text: ShopController.to.totalCoins.value.toString(),
                  //           style: Theme.of(context)
                  //             .textTheme
                  //             .headline6!
                  //             .copyWith(
                  //               fontFamily: 'Scada',
                  //               fontSize: smallText,
                  //               fontWeight: FontWeight.w400,
                  //               color: Colors.black87,
                  //             ), 
                  //         ),
                  //         TextSpan(
                  //           text: ' + ($coinsEarned)',
                  //           style: Theme.of(context)
                  //             .textTheme
                  //             .headline6!
                  //             .copyWith(
                  //               fontFamily: 'Scada',
                  //               fontSize: smallText,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.black,
                  //             ), 
                  //         ),
                  //       ]
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: Spacing.mediumSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.popAndPushNamed(context, 'characterSelectScreen');
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: SvgPicture.asset('assets/icons/repeat-icon.svg', fit: BoxFit.fill),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(context, 'mainMenuScreen', (route) => route.isFirst);
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: SvgPicture.asset('assets/icons/back2-home-icon.svg', fit: BoxFit.fill)
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Container(
                  //       width: MediaQuery.of(context).size.width * 0.3,
                  //       // color: Colors.pink.shade400,
                  //       child: Center(
                  //         child: Text('Main lagi',
                  //           textAlign: TextAlign.center,
                  //           style: Theme.of(context)
                  //             .textTheme
                  //             .headline5!
                  //             .copyWith(
                  //               fontFamily: 'Scada',
                  //               fontSize: smallText,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.black87
                  //             ),
                  //         ),
                  //       )
                  //     ),
                  //     Container(
                  //       width: MediaQuery.of(context).size.width * 0.3,
                  //       // color: Colors.cyan.shade400,
                  //       child: Center(
                  //         child: Text('Kembali ke menu utama',
                  //           textAlign: TextAlign.center,
                  //           style: Theme.of(context)
                  //             .textTheme
                  //             .headline5!
                  //             .copyWith(
                  //               fontFamily: 'Scada',
                  //               fontSize: smallText,
                  //               fontWeight: FontWeight.w600,
                  //               color: Colors.black87
                  //             ),
                  //         ),
                  //       )
                  //     ),
                  //   ],
                  // )
                  SizedBox(height: Spacing.mediumSpacing),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}