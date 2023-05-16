// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/immune-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/widgets/text-content-lesson.dart';

class ImmuneDiseasePage extends StatefulWidget{
  const ImmuneDiseasePage({super.key});

  @override
  State<ImmuneDiseasePage> createState() => _ImmuneDiseasePageState();
}

class _ImmuneDiseasePageState extends State<ImmuneDiseasePage> {

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
          const SubTitleContent(subTitle: 'Gangguan Sistem Pertahanan Tubuh'),
          SizedBox(height: Spacing.smallSpacing),
          const SubTitleContent(subTitle: 'Hipersensivitas (Alergi)'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: alergyDisease),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: 'Autoimun'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: autoimunDisease),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: 'Imunodefisiensi'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: imunodefisiensiDisease),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: 'Isoimunitas (Alloimunitas)'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: isoimunitasDisease),
          SizedBox(height: Spacing.mediumSpacing),
        ],
      ),
    );
  }
}