// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/immune-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/widgets/text-content-lesson.dart';

class AboutImmuneSystemPage extends StatefulWidget{
  const AboutImmuneSystemPage({super.key});

  @override
  State<AboutImmuneSystemPage> createState() => _AboutImmuneSystemPageState();
}

class _AboutImmuneSystemPageState extends State<AboutImmuneSystemPage> {

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
          const SubTitleContent(subTitle: 'Tentang Sistem Pertahanan Tubuh'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: immuneSystemAbout),
          SizedBox(height: Spacing.mediumSpacing),
        ],
      ),
    );
  }
}