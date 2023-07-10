// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class GetDebuffDialog extends StatelessWidget{
  const GetDebuffDialog({super.key, required this.title, required this.content, required this.onPress});

  final String title;
  final String content;
  final VoidCallback onPress;

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
              height: MediaQuery.of(context).size.height * 0.175,
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
                      color: Colors.amber.shade400,
                      // border: Border(bottom: BorderSide(color: plainBlackBackground, width: 1)),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)
                      )
                    ),
                    child: Center(
                      child: Text(title,
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.smallSpacing),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    // color: Colors.yellow,
                    child: Center(
                      child: Text(content,
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
            Center(
              child: GestureDetector(
                onTap: onPress,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  padding: EdgeInsets.all(Spacing.smallSpacing),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: plainBlackBackground, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:Center(
                    child:  Text('Tutup',
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
            )
          ],
        ),
      ),
    );
  }
}