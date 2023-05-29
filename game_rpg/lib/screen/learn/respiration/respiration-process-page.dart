// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/respiration-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/widgets/custom-expand-btn.dart';

class RespirationProcessPage extends StatefulWidget{
  const RespirationProcessPage({super.key});

  @override
  State<RespirationProcessPage> createState() => _RespirationProcessPageState();
}

class _RespirationProcessPageState extends State<RespirationProcessPage> {
  bool process1 = false;
  bool process2 = false;
  bool howRespirationWorks = false;

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
          Text(respirationProcessOverview,
            textAlign: TextAlign.justify,
            style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(
                fontFamily: 'Scada',
                fontWeight: FontWeight.w500,
                fontSize: smallText,
                color: Colors.white
              ),
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Proses Pernapasan', 
            onPressed: () {
              if(!howRespirationWorks){
                setState(() {
                  howRespirationWorks = true;
                });
              }else{
                setState(() {
                  howRespirationWorks = false;
                });
              }
            }
          ),
          infoSection(whichProcess: howRespirationWorks, content: respirationProcess,
            openSection: (){
              if (!howRespirationWorks) {
                setState(() {
                  howRespirationWorks = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
          CustomExpandBtn(
            title: 'Pernapasan Dada', 
            onPressed: () {
              if(!process1){
                setState(() {
                  process1 = true;
                });
              }else{
                setState(() {
                  process1 = false;
                });
              }
            }
          ),
          infoSection(whichProcess: process1, content: respirationChest,
            openSection: (){
              if (!process1) {
                setState(() {
                  process1 = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
          CustomExpandBtn(
            title: 'Pernapasan Perut', 
            onPressed: () {
              if(!process2){
                setState(() {
                  process2 = true;
                });
              }else{
                setState(() {
                  process2 = false;
                });
              }
            }
          ),
          infoSection(whichProcess: process2, content: respirationStomach,
            openSection: (){
              if (!process2) {
                setState(() {
                  process2 = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
        ],
      ),
    );
  }

  Widget infoSection({required bool whichProcess, required String content, required Function() openSection}){
    if (whichProcess) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(Spacing.smallSpacing),
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          border: const Border(
            left: BorderSide(color: Colors.black45, width: 2),
            right: BorderSide(color: Colors.black45, width: 2),
            bottom: BorderSide(color: Colors.black45, width: 2),
          )
        ),
        child:  Text(content,
          textAlign: TextAlign.justify,
          style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(
              fontFamily: 'Scada',
              fontWeight: FontWeight.w500,
              fontSize: smallText,
              color: Colors.black87
            ),
          )
      );
    } else {
      return GestureDetector(
        onTap: openSection,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(Spacing.smallSpacing),
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            border: const Border(
              left: BorderSide(color: Colors.black45, width: 2),
              right: BorderSide(color: Colors.black45, width: 2),
              bottom: BorderSide(color: Colors.black45, width: 2),
            )
          ),
          child: Center(
            child: Text('Sentuh untuk melihat',
              textAlign: TextAlign.center,
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
          ),
        ),
      );
    }
  }
}