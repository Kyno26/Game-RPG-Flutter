// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class SubTitleContent extends StatelessWidget{
  const SubTitleContent({super.key, required this.subTitle});

  final String subTitle;

  @override
  Widget build(BuildContext context) {
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
}

class ContentText extends StatelessWidget{
  const ContentText({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(content,
        textAlign: TextAlign.justify,
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
    );
  }
}