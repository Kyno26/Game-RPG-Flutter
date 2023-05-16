// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/immune-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/widgets/text-content-lesson.dart';

class ImmuneSpecificPage extends StatefulWidget{
  const ImmuneSpecificPage({super.key});

  @override
  State<ImmuneSpecificPage> createState() => _ImmuneSpecificPageState();
}

class _ImmuneSpecificPageState extends State<ImmuneSpecificPage> {

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
          const SubTitleContent(subTitle: 'Sistem Pertahanan Tubuh Spesifik'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: immuneSpecific),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: 'Pertahanan Spesifik Seluler'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: specificSeluler),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: 'Pertahanan Spesifik Humoral'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: specificHumoral),
          SizedBox(height: Spacing.mediumSpacing),
        ],
      ),
    );
  }
}