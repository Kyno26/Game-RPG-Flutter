// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class NewGameDialog extends StatelessWidget {
  const NewGameDialog({super.key, 
    required this.title, 
    required this.subTitle,
    required this.yesBtnPressed, 
    required this.noBtnPressed, 
    required this.yesContent, 
    required this.noContent, 
  });

  final String title;
  final String subTitle;
  final VoidCallback yesBtnPressed;
  final String yesContent;
  final VoidCallback noBtnPressed;
  final String noContent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: Colors.amber.shade500,
                      // border: Border(bottom: BorderSide(color: plainBlackBackground, width: 1)),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)
                      )
                    ),
                    child: Center(
                      child: Text('PERINGATAN',
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontSize: smallText,
                            fontWeight: FontWeight.w700,
                            color: Colors.black
                          ),
                      ),
                    )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    // color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(
                              fontFamily: 'Scada',
                              fontSize: smallText,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                            ),
                        ),
                        Text(subTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(
                              fontFamily: 'Scada',
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: redColor
                            ),
                        ),
                      ],
                    )
                  )
                ],
              )
            ),
            SizedBox(height: Spacing.mediumSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: yesBtnPressed,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    padding: EdgeInsets.all(Spacing.smallSpacing),
                    decoration: BoxDecoration(
                      color: redColor,
                      border: Border.all(color: plainBlackBackground, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:Center(
                      child:  Text(yesContent,
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
                GestureDetector(
                  onTap: noBtnPressed,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    padding: EdgeInsets.all(Spacing.smallSpacing),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: plainBlackBackground, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(noContent,
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontSize: smallText,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                      ),
                    )
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}