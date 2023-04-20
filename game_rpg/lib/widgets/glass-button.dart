import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class GlassButton extends StatelessWidget{
  const GlassButton({super.key, 
    required this.title, 
    required this.subTitle, 
    this.redSubtitle = false,
    required this.iconFile, 
    required this.onPress, 
    this.subTitleColor  = softGreyColor, 
    this.btnColor = glassWhiteColor, 
    this.btnBorderColor = glassWhiteBorder, 
    this.subtitleOn = true,
  });

  final String title;
  final bool redSubtitle;
  final bool subtitleOn;
  final String subTitle;
  final String iconFile;
  final VoidCallback onPress;
  final Color subTitleColor;
  final Color btnColor;
  final Color btnBorderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: GlassContainer(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.175,
        color: btnColor,
        blur: 3,
        border: Border.all(color: btnBorderColor, width: 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.075,
              height: MediaQuery.of(context).size.width * 0.075,
              child: SvgPicture.asset('assets/icons/$iconFile.svg', fit: BoxFit.fill, color: Colors.white,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(title,
                    style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(
                        fontFamily: 'Scada',
                        fontSize: homeText,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),
                  ),
                ),
                if(subtitleOn)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Text(subTitle,
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontSize: 9,
                          fontWeight: FontWeight.w400,
                          color: (redSubtitle) ? softRedColor : softGreyColor
                        ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

}