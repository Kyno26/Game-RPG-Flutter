// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/model/character.dart';

class CharacterBox extends StatefulWidget{
  const CharacterBox({super.key, required this.character});

  final Character character;

  @override
  State<CharacterBox> createState() => _CharacterBoxState();
}

class _CharacterBoxState extends State<CharacterBox>{
  bool isLoading = true;
  bool unlocked = false;
  late int characterStar;

  @override
  void initState() {
    unlocked = CharacterController.to.checkCharacterUnlockStatus(characterId: widget.character.id);
    characterStar = CharacterController.to.checkCharacterStar(characterId: widget.character.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('===== DATA CHARACTER =====');
        debugPrint(widget.character.id.toString());
        debugPrint(widget.character.name.toString());
        debugPrint(unlocked.toString());
        debugPrint('=========================');
        CharacterController.to.checkCharacterDetail(charactedID: widget.character.id);
        Navigator.pushNamed(context, 'characterInfoScreen');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade500),
          color: softWhiteColor
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade700, width: 1))
              ),
              child: Image.asset((unlocked) ? widget.character.imageUnlocked : widget.character.imageLocked, fit: BoxFit.cover,),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: EdgeInsets.all(Spacing.smallSpacing),
              child: Column(
                children: [
                  Text((unlocked) ? widget.character.name : '???',
                    style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(
                        fontFamily: 'Scada',
                        fontSize: smallText,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                      ),
                  ),
                  // Text('Peran: ',
                  //   style: Theme.of(context)
                  //     .textTheme
                  //     .headline5!
                  //     .copyWith(
                  //       fontFamily: 'Scada',
                  //       fontSize: smallerText,
                  //       fontWeight: FontWeight.w400,
                  //       color: Colors.black
                  //     ),
                  // ),
                  // Text((!unlocked) ? '???' : widget.character.job,
                  //   style: Theme.of(context)
                  //     .textTheme
                  //     .headline5!
                  //     .copyWith(
                  //       fontFamily: 'Scada',
                  //       fontSize: smallerText,
                  //       fontWeight: FontWeight.w400,
                  //       color: Colors.black
                  //     ),
                  // ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}