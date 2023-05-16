// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class CustomExpandBtn extends StatefulWidget{
  const CustomExpandBtn({super.key, required this.title, required this.onPressed});

  final String title;
  final Function() onPressed;

  @override
  State<CustomExpandBtn> createState() => _CustomExpandBtnState();
}

class _CustomExpandBtnState extends State<CustomExpandBtn> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing),
        decoration: BoxDecoration(
          color: Colors.yellow,
          border: Border.all(color: Colors.black45, width: 2)
        ),
        child: Center(
          child: Text(widget.title,
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
    );
  }
}