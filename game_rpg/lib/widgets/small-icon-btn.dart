import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class IconBtnSmall extends StatelessWidget{

  const IconBtnSmall({super.key, 
    required this.title, 
    required this.txtColor, 
    required this.iconFile
  });
  
  final String title;
  final Color txtColor;
  final String iconFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      height: MediaQuery.of(context).size.width * 0.15,
      // color: Colors.amberAccent,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.125,
            height: MediaQuery.of(context).size.width * 0.125,
            child: SvgPicture.asset(iconFile, fit: BoxFit.fill,)
        ),
        Positioned(
          bottom: 5,
          child: GlassContainer(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(5),
            blur: 5,
            border: const Border.fromBorderSide(BorderSide.none),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.miniSpacing),
              child: Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
                    color: txtColor,
              ),
            ),
            )
          )
        )
      ],
    ),
    );
  }
}