import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class InfoDialog extends StatelessWidget{
  const InfoDialog({super.key, 
    required this.title, 
    required this.content
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.all(Spacing.mediumSpacing),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                )
              ),
              child: Center(
                child: Text(title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(
                        fontFamily: 'Scada',
                        fontWeight: FontWeight.w700,
                        fontSize: smallText,
                        color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.275,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade400, width: 0.5))
              ),
              padding: EdgeInsets.symmetric(horizontal: Spacing.mediumSpacing,),
              child: SingleChildScrollView(
                child: Text(content,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontWeight: FontWeight.w400,
                          fontSize: smallerText,
                          color: Colors.black,
                    ),
                  ),
              )
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint('Info Dialog Closed');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                )
              ),
              child: Text('Tutup',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(
                      fontFamily: 'Scada',
                      fontWeight: FontWeight.w600,
                      fontSize: smallText,
                      color: Colors.white,
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}