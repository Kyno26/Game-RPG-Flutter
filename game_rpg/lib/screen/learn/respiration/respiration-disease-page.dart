// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/respiration-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class RespirationDiseasePage extends StatefulWidget{
  const RespirationDiseasePage({super.key});

  @override
  State<RespirationDiseasePage> createState() => _RespirationDiseasePageState();
}

class _RespirationDiseasePageState extends State<RespirationDiseasePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Text('Gangguan pada Sistem Pernapasan Manusia',
            textAlign: TextAlign.justify,
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
          subTitleContent(subTitle: 'Flu'),
          contentText(content: fluText),
          SizedBox(height: Spacing.smallSpacing),
          subTitleContent(subTitle: 'Asma'),
          contentText(content: asmaText),
          SizedBox(height: Spacing.smallSpacing),
          subTitleContent(subTitle: 'Pneumonia'),
          contentText(content: pneumoniaText),
          SizedBox(height: Spacing.smallSpacing),
          subTitleContent(subTitle: 'Tuberculosis (TBC)'),
          contentText(content: tbcText),
          SizedBox(height: Spacing.smallSpacing),
          subTitleContent(subTitle: 'Bronkitis'),
          contentText(content: bronkitisText),
          SizedBox(height: Spacing.mediumSpacing),
          Text('Cara Menjaga Organ Pernapasan',
            textAlign: TextAlign.justify,
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
          contentText(content: howToKeepHealthy),
          SizedBox(height: Spacing.mediumSpacing)
        ],
      ),
    );
  }

  Widget subTitleContent({required String subTitle}){
    return Align(
      alignment: Alignment.topLeft,
      child: Text(subTitle,
        textAlign: TextAlign.justify,
        style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(
            fontFamily: 'Scada',
            fontWeight: FontWeight.w700,
            fontSize: smallText,
            color: Colors.black
          ),
      ),
    );
  }

  Widget contentText({required String content}){
    return Text(content,
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
    );
  }
}