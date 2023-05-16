// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/digesting-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/widgets/text-content-lesson.dart';

class DigestingProcessPage extends StatefulWidget{
  const DigestingProcessPage({super.key});

  @override
  State<DigestingProcessPage> createState() => _DigestingProcessPageState();
}

class _DigestingProcessPageState extends State<DigestingProcessPage> {

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
          const SubTitleContent(subTitle: 'Proses Pencernaan'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: digestingProcess),
          SizedBox(height: Spacing.mediumSpacing),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset('assets/images/material/enzim-table.png', fit: BoxFit.fill,),
          ),
          SizedBox(height: Spacing.mediumSpacing),
        ],
      ),
    );
  }
}