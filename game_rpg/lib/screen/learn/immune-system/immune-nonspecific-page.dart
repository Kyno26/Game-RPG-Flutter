// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/immune-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/widgets/text-content-lesson.dart';

class ImmuneNonSpecificPage extends StatefulWidget{
  const ImmuneNonSpecificPage({super.key});

  @override
  State<ImmuneNonSpecificPage> createState() => _ImmuneNonSpecificPageState();
} 

class _ImmuneNonSpecificPageState extends State<ImmuneNonSpecificPage> {

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
          const SubTitleContent(subTitle: 'Sistem Pertahanan Tubuh Nonspesifik'),
          SizedBox(height: Spacing.mediumSpacing),
          const ContentText(content: immuneNonSpecific),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: 'Pertahanan Nonspesifik Eksternal'),
          SizedBox(height: Spacing.smallSpacing),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.3,
            child: Image.asset('assets/images/material/skin-image.png', fit: BoxFit.fill),
          ),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: nonspecificExternal),
          SizedBox(height: Spacing.mediumSpacing),
          const SubTitleContent(subTitle: 'Pertahanan Nonspesifik Internal'),
          SizedBox(height: Spacing.smallSpacing),
          const ContentText(content: nonspecificInternal),
        ],
      ),
    );
  }
}