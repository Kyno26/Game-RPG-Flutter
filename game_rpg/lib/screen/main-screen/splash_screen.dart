import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class SplashSreen extends StatefulWidget{
  const SplashSreen({super.key});

  @override
  State<SplashSreen> createState() => _SplashSreenState();
}

class _SplashSreenState extends State<SplashSreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(context, 'startScreen');
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitApp = false;
        return exitApp;
      },
      child: Scaffold(
        backgroundColor: plainBlackBackground,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeIn(
              delay: const Duration(milliseconds: 1000),
              duration: const Duration(milliseconds: 1750),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(Spacing.mediumSpacing),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.width * 0.35,
                        child: SvgPicture.asset('assets/icons/info-icon-large.svg', fit: BoxFit.fill, color: Colors.grey.shade300),
                      ),
                      SizedBox(height: Spacing.largeSpacing * 2),
                      Text('Semua asset seperti gambar dan audio di dalam game bukan milik pengembang, kesamaan nama merupakan kebetulan',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontSize: smallText,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                      ),
                      SizedBox(height: Spacing.mediumSpacing),
                      Text('Harap mainkan game apapun secukupnya dan jangan lupa beristirahat',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontSize: smallText,
                            fontWeight: FontWeight.w900,
                            color: Colors.yellow,
                          ),
                      ),
                    ],
                  ),
                )
              )
            )
          ],
        ),
      ), 
    );
  }
}