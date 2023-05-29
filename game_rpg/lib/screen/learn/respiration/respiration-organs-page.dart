// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/respiration-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/widgets/custom-expand-btn.dart';

class RespirationOrganPage extends StatefulWidget{
  const RespirationOrganPage({super.key});

  @override
  State<RespirationOrganPage> createState() => _RespirationOrganPageState();
}

class _RespirationOrganPageState extends State<RespirationOrganPage> {
  bool organ1 = false;
  bool organ2 = false;
  bool organ3 = false;
  bool organ4 = false;
  bool organ5 = false;
  bool organ6 = false;

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
          Text(respirationOrganOverview,
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
            title: 'Rongga Hidung', 
            onPressed: () {
              if(!organ1){
                setState(() {
                  organ1 = true;
                });
              }else{
                setState(() {
                  organ1 = false;
                });
              }
            }
          ),
          //Info Section
          infoSection(whichOrgan: organ1, content: respirationOrgan1,
            openSection: (){
              if (!organ1) {
                setState(() {
                  organ1 = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
          CustomExpandBtn(
            title: 'Faring', 
            onPressed: () {
              if(!organ2){
                setState(() {
                  organ2 = true;
                });
              }else{
                setState(() {
                  organ2 = false;
                });
              }
            }
          ),
          //Info Section
          infoSection(whichOrgan: organ2, content: respirationOrgan2,
            openSection: (){
              if (!organ2) {
                setState(() {
                  organ2 = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
          CustomExpandBtn(
            title: 'Trakea', 
            onPressed: () {
              if(!organ3){
                setState(() {
                  organ3 = true;
                });
              }else{
                setState(() {
                  organ3 = false;
                });
              }
            }
          ),
          //Info Section
          infoSection(whichOrgan: organ3, content: respirationOrgan3,
            openSection: (){
              if (!organ3) {
                setState(() {
                  organ3 = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
          CustomExpandBtn(
            title: 'Laring', 
            onPressed: () {
              if(!organ4){
                setState(() {
                  organ4 = true;
                });
              }else{
                setState(() {
                  organ4 = false;
                });
              }
            }
          ),
          //Info Section
          infoSection(whichOrgan: organ4, content: respirationOrgan4,
            openSection: (){
              if (!organ4) {
                setState(() {
                  organ4 = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
          CustomExpandBtn(
            title: 'Bronkus', 
            onPressed: () {
              if(!organ5){
                setState(() {
                  organ5 = true;
                });
              }else{
                setState(() {
                  organ5 = false;
                });
              }
            }
          ),
          //Info Section
          infoSection(whichOrgan: organ5, content: respirationOrgan5,
            openSection: (){
              if (!organ5) {
                setState(() {
                  organ5 = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
          CustomExpandBtn(
            title: 'Paru-paru', 
            onPressed: () {
              if(!organ6){
                setState(() {
                  organ6 = true;
                });
              }else{
                setState(() {
                  organ6 = false;
                });
              }
            }
          ),
          //Info Section
          infoSection(whichOrgan: organ6, content: respirationOrgan6,
            openSection: (){
              if (!organ6) {
                setState(() {
                  organ6 = true;
                });
              }
            }),
          SizedBox(height: Spacing.smallSpacing),
        ],
      ),
    );
  }

  Widget infoSection({required bool whichOrgan, required String content, required Function() openSection}){
    if (whichOrgan) {
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