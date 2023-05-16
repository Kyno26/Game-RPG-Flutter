// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/digesting-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/widgets/text-content-lesson.dart';

class AboutDigestingPage extends StatefulWidget{
  const AboutDigestingPage({super.key});

  @override
  State<AboutDigestingPage> createState() => _AboutDigestingPageState();
}

class _AboutDigestingPageState extends State<AboutDigestingPage> {

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
          const ContentText(content: digestingOverview),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: 'Apa yang terjadi pada makanan yang dicerna'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: whatHappenToFood),
          SizedBox(height: Spacing.mediumSpacing),
        ],
      ),
    );
  }
}