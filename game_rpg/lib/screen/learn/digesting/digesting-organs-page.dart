// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/digesting-text.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/widgets/custom-expand-btn.dart';
import 'package:game_rpg/widgets/info-section.dart';

class DigestingOrgansPage extends StatefulWidget{
  const DigestingOrgansPage({super.key});

  @override
  State<DigestingOrgansPage> createState() => _DigestingOrgansPageState();
}

class _DigestingOrgansPageState extends State<DigestingOrgansPage> {
  bool section1 = false;
  bool section2 = false;
  bool section3 = false;
  bool section4 = false;
  bool section5 = false;
  bool section6 = false;
  bool section7 = false;
  bool section8 = false;
  bool section9 = false;

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
          CustomExpandBtn(
            title: 'Mulut', 
            onPressed: (){
              if (!section1) {
                setState(() {
                  section1 = true;
                });
              } else {
                setState(() {
                  section1 = false;
                });
              }
            }
          ),
          InfoSection(
            content: mouthContent, 
            onPress: (){
              setState(() {
                section1 = true;
              });
            }, 
            boolVar: section1
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Kerongkongan', 
            onPressed: (){
              if (!section2) {
                setState(() {
                  section2 = true;
                });
              } else {
                setState(() {
                  section2 = false;
                });
              }
            }
          ),
          InfoSection(
            content: kerongkonganContent, 
            onPress: (){
              setState(() {
                section2 = true;
              });
            }, 
            boolVar: section2
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Lambung', 
            onPressed: (){
              if (!section3) {
                setState(() {
                  section3 = true;
                });
              } else {
                setState(() {
                  section3 = false;
                });
              }
            }
          ),
          InfoSection(
            content: lambungContent, 
            onPress: (){
              setState(() {
                section3 = true;
              });
            }, 
            boolVar: section3,
            imageExist: true,
            imageSquare: false,
            image: 'assets/images/material/lambung.png',
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Pankreas', 
            onPressed: (){
              if (!section4) {
                setState(() {
                  section4 = true;
                });
              } else {
                setState(() {
                  section4 = false;
                });
              }
            }
          ),
          InfoSection(
            content: pancreasContent, 
            onPress: (){
              setState(() {
                section4 = true;
              });
            }, 
            boolVar: section4
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Kantong Empedu', 
            onPressed: (){
              if (!section5) {
                setState(() {
                  section5 = true;
                });
              } else {
                setState(() {
                  section5 = false;
                });
              }
            }
          ),
          InfoSection(
            content: empeduContent, 
            onPress: (){
              setState(() {
                section5 = true;
              });
            }, 
            boolVar: section5
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Usus Halus', 
            onPressed: (){
              if (!section6) {
                setState(() {
                  section6 = true;
                });
              } else {
                setState(() {
                  section6 = false;
                });
              }
            }
          ),
          InfoSection(
            content: ususHalusContent, 
            onPress: (){
              setState(() {
                section6 = true;
              });
            }, 
            boolVar: section6,
            imageExist: true,
            imageSquare: false,
            image: 'assets/images/material/usus-halus.jpg',
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Usus Besar', 
            onPressed: (){
              if (!section7) {
                setState(() {
                  section7 = true;
                });
              } else {
                setState(() {
                  section7 = false;
                });
              }
            }
          ),
          InfoSection(
            content: ususBesarContent, 
            onPress: (){
              setState(() {
                section7 = true;
              });
            }, 
            boolVar: section7,
            imageExist: true,
            imageSquare: false,
            image: 'assets/images/material/usus-besar.jpg',
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Rektum', 
            onPressed: (){
              if (!section8) {
                setState(() {
                  section8 = true;
                });
              } else {
                setState(() {
                  section8 = false;
                });
              }
            }
          ),
          InfoSection(
            content: rektumContent, 
            onPress: (){
              setState(() {
                section8 = true;
              });
            }, 
            boolVar: section8
          ),
          SizedBox(height: Spacing.mediumSpacing),
          CustomExpandBtn(
            title: 'Anus', 
            onPressed: (){
              if (!section9) {
                setState(() {
                  section9 = true;
                });
              } else {
                setState(() {
                  section9 = false;
                });
              }
            }
          ),
          InfoSection(
            content: anusContent, 
            onPress: (){
              setState(() {
                section9 = true;
              });
            }, 
            boolVar: section9
          ),
          SizedBox(height: Spacing.mediumSpacing),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            child: Image.asset('assets/images/material/enzim-table.png', fit: BoxFit.fill,),
          ),
          SizedBox(height: Spacing.mediumSpacing),
        ],
      ),
    );
  }
}