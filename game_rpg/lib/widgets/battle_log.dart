import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:get/get.dart';

class BattleLog extends StatefulWidget{
  const BattleLog({super.key});

  @override
  State<BattleLog> createState() => _BattleLogState();
}

class _BattleLogState extends State<BattleLog> {
  late Image logBg;

  @override
  void initState() {
    logBg = Image.asset('assets/images/background/scroll-parchment.png');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(logBg.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.5,
        padding: EdgeInsets.symmetric(vertical: Spacing.largeSpacing, horizontal: Spacing.bigSpacing),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/scroll-parchment.png'),
            fit: BoxFit.fill,
          )
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: Spacing.smallSpacing),
              Center(
                child: Text('Log Pertempuran',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                      fontFamily: 'Scada',
                      fontSize: homeText,
                      fontWeight: FontWeight.w700,
                      color: plainBlackBackground
                    ),
                ),
              ),
              SizedBox(height: Spacing.smallSpacing),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                height: MediaQuery.of(context).size.height * 0.325,
                child: Obx(() => ListView.separated(
                  itemCount: BattleFieldController.to.battleLog.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: Spacing.miniSpacing), 
                  itemBuilder: (context, index) => 
                    Text(BattleFieldController.to.battleLog[index],
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontSize: smallText,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87
                        ),
                    ), 
                )),
              ),
            ],
          )
        )
      )
    );
  }
}