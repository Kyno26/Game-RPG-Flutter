// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/respiration-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class AboutRespirationPage extends StatefulWidget{
  const AboutRespirationPage({super.key});

  @override
  State<AboutRespirationPage> createState() => _AboutRespirationPageState();
}

class _AboutRespirationPageState extends State<AboutRespirationPage> {
  bool functionPressed = false;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Text(respirationIntroduction,
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w500,
                    fontSize: smallText,
                    color: Colors.black87
                  ),
              ),
              SizedBox(height: Spacing.mediumSpacing),
              GestureDetector(
                onTap: (){
                  if (!functionPressed) {
                    setState(() {
                      functionPressed = true;
                    });
                  } else {
                    setState(() {
                      functionPressed = false;
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    border: Border.all(color: Colors.black45, width: 2)
                  ),
                  child: Center(
                    child: Text('Fungsi Sistem Pernapasan',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontWeight: FontWeight.w700,
                          fontSize: averageText,
                          color: Colors.black
                        ),
                    ),
                  ),
                ),
              ),
              functionInfo(openSection: (){
                if (!functionPressed) {
                  setState(() {
                    functionPressed = true;
                  });
                }
              }),
              SizedBox(height: Spacing.smallSpacing),
            ],
          )
        )
      ],
    );
  }

  Widget functionInfo({required Function() openSection}){
    if(functionPressed){
      return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(Spacing.smallSpacing),
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          border: const Border(
            left: BorderSide(color: Colors.black45, width: 2),
            right: BorderSide(color: Colors.black45, width: 2),
            bottom: BorderSide(color: Colors.black45, width: 2),
          )
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text('1. Bernapas',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: smallText,
                    color: Colors.black87
                  ),
              ),
            ),
            Text(respirationFunction1,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w500,
                  fontSize: smallText,
                  color: Colors.black87
                ),
            ),
            SizedBox(height: Spacing.smallSpacing),
            Align(
              alignment: Alignment.topLeft,
              child: Text('2. Pertukaran Gas antara Paru-Paru dan Aliran Darah',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: smallText,
                    color: Colors.black87
                  ),
              ),
            ),
            Text(respirationFunction2,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w500,
                  fontSize: smallText,
                  color: Colors.black87
                ),
            ),
            SizedBox(height: Spacing.smallSpacing),
            Align(
              alignment: Alignment.topLeft,
              child: Text('3. Pertukaran gas antara aliran darah dan jaringan di dalam tubuh',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: smallText,
                    color: Colors.black87
                  ),
              ),
            ),
            Text(respirationFunction3,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w500,
                  fontSize: smallText,
                  color: Colors.black87
                ),
            ),
            SizedBox(height: Spacing.smallSpacing),
            Align(
              alignment: Alignment.topLeft,
              child: Text('4. Mencium Bau',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: smallText,
                    color: Colors.black87
                  ),
              ),
            ),
            Text(respirationFunction4,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w500,
                  fontSize: smallText,
                  color: Colors.black87
                ),
            ),
            SizedBox(height: Spacing.smallSpacing),
            Align(
              alignment: Alignment.topLeft,
              child: Text('5. Menghasilkan Suara',
                textAlign: TextAlign.left,
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: smallText,
                    color: Colors.black87
                  ),
              ),
            ),
            Text(respirationFunction5,
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w500,
                  fontSize: smallText,
                  color: Colors.black87
                ),
            ),
          ],
        ),
      );
    }else{
      return GestureDetector(
        onTap: openSection,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(Spacing.smallSpacing),
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            border: const Border(
              left: BorderSide(color: Colors.black45, width: 2),
              right: BorderSide(color: Colors.black45, width: 2),
              bottom: BorderSide(color: Colors.black45, width: 2),
            )
          ),
          child: Center(
            child: Text('Sentuh untuk melihat',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w500,
                  fontSize: smallText,
                  color: Colors.black
                ),
            ),
          ),
        ),
      );
    }
  }
}