// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/digesting-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/widgets/text-content-lesson.dart';

class DigestingDiseasePage extends StatefulWidget{
  const DigestingDiseasePage({super.key});

  @override
  State<DigestingDiseasePage> createState() => _DigestingDiseasePageState();
}

class _DigestingDiseasePageState extends State<DigestingDiseasePage> {

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
          Align(
            alignment: Alignment.topLeft,
            child: Text('Gangguan pada Sistem Pencernaan',
                textAlign: TextAlign.justify,
                style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w800,
                    fontSize: averageText,
                    color: Colors.black
                  ),
              ),
          ),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: '1. Sembelit'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: digestingDiease1),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: '2. Diare'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: digestingDiease2),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: '3. Wasir'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: digestingDiease3),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: '4. Flu Perut (Gastroenteritis)'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: digestingDiease4),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: '5. Bisul'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: digestingDiease5),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: '6. Batu Empedu'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: digestingDiease6),
          SizedBox(height: Spacing.mediumSpacing * 2),
          const SubTitleContent(subTitle: 'Cara Menjaga Kesehatan Pencernaan'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: howToKeepHealtyDigestive),
          SizedBox(height: Spacing.mediumSpacing),
        ],
      ),
    );
  }
}