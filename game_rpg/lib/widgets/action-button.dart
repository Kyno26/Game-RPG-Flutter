// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class ActionButton extends StatelessWidget{
  const ActionButton({super.key, 
    required this.title, 
    required this.onPress
  });

  final String title;
  final VoidCallback onPress;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.width * 0.1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/wood-platform.png'),
            fit: BoxFit.fitWidth 
          )
        ),
        child: Center(
          child: Text(title,
            style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(
                fontFamily: 'Scada',
                fontSize: smallText,
                fontWeight: FontWeight.w700,
                color: Colors.black
              ),
          ),
        ),
      ),
    );
  }

}