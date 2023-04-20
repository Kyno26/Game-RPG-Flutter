// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key, 
    required this.title, 
    required this.yesBtnPressed, 
    required this.noBtnPressed, 
    required this.yesContent, 
    required this.noContent
  });

  final String title;
  final VoidCallback yesBtnPressed;
  final String yesContent;
  final VoidCallback noBtnPressed;
  final String noContent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.25,
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: const BoxDecoration(
                      color: redColor,
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
                            color: Colors.white
                          ),
                      ),
                    )
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.075,
                    // color: Colors.yellow,
                    child: Center(
                      child: Text(title,
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
                    ),
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