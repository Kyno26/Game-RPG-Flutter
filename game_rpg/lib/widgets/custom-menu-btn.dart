// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class CustomMenuBtn extends StatefulWidget{
  const CustomMenuBtn({super.key, required this.title, required this.onPress, required this.menuOpt});

  final String title;
  final Function() onPress;
  final bool menuOpt;

  @override
  State<CustomMenuBtn> createState() => _CustomMenuBtnState();
}

class _CustomMenuBtnState extends State<CustomMenuBtn> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing, horizontal: Spacing.smallSpacing),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: widget.menuOpt ? Colors.green : Colors.white,
          borderRadius: BorderRadiusDirectional.circular(5)
        ),
        child: Center(
          child: Text(widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(
                fontFamily: 'Scada',
                fontWeight: FontWeight.w600,
                fontSize: smallText,
                color: widget.menuOpt ? Colors.white : Colors.black
              ),
          ),
        ),
      ),
    );
  }
}