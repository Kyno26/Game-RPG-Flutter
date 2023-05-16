// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:game_rpg/widgets/answer-button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:quiver/async.dart';

class QuestionBasic extends StatefulWidget{
  const QuestionBasic({super.key, 
    required this.question, 
    required this.option1, 
    required this.option2, 
    required this.option3, 
    required this.option4,
  });

  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  @override
  State<QuestionBasic> createState() => _QuestionBasicState();
}

class _QuestionBasicState extends State<QuestionBasic> {
  
  String clicked = '0';
  bool showAnswer = false;
  late StreamSubscription<CountdownTimer> sub;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // QuestionController.to.clearQuestionValue();
    QuestionController.to.showAnswer.value = false;
    QuestionController.to.showAnimation.value = false;
    sub.cancel();
    super.dispose();
  }

  startTimer(){
    CountdownTimer countdownTimer = CountdownTimer(
      Duration(seconds: QuestionController.to.maxTime.value), 
      const Duration(seconds: 1)
    );
    sub = countdownTimer.listen((event) {
      
    });
    sub.onData((duration) {
      QuestionController.to.curTime.value = 0;
      QuestionController.to.curTime.value = QuestionController.to.maxTime.value - duration.elapsed.inSeconds;
    });
    sub.onDone(() {
      QuestionController.to.checkAnswer();
      setState(() {
        showAnswer = true;
        sub.cancel();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.2,
              padding: EdgeInsets.all(Spacing.mediumSpacing),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 2),
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                  image: AssetImage('assets/images/background/paper-texture.jpg'),
                  fit: BoxFit.fill
                )
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(widget.question,
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
                ],
              )
            ),
            SizedBox(height: Spacing.mediumSpacing),
            
            AnswerButton(
              textAnswer: widget.option1, 
              onPressed: () {
                if(!showAnswer){
                  setState(() {
                    clicked = '1';
                  });
                  QuestionController.to.selectedAnswer.value = widget.option1;
                }
              }, 
              index: '1', 
              selected: clicked, 
              showAnswer: showAnswer,
            ),
            SizedBox(height: Spacing.smallSpacing),
            AnswerButton(
              textAnswer: widget.option2, 
              onPressed: () {
                if(!showAnswer){
                  setState(() {
                    clicked = '2';
                  });
                  QuestionController.to.selectedAnswer.value = widget.option2;
                }
              }, 
              index: '2', 
              selected: clicked, 
              showAnswer: showAnswer,
            ),
            SizedBox(height: Spacing.smallSpacing),
            AnswerButton(
              textAnswer: widget.option3, 
              onPressed: () {
                if(!showAnswer){
                  setState(() {
                    clicked = '3';
                  });
                  QuestionController.to.selectedAnswer.value = widget.option3;
                }
              }, 
              index: '3', 
              selected: clicked, 
              showAnswer: showAnswer,
            ),
            SizedBox(height: Spacing.smallSpacing),
            AnswerButton(
              textAnswer: widget.option4, 
              onPressed: () {
                if(!showAnswer){
                  setState(() {
                    clicked = '4';
                  });
                  QuestionController.to.selectedAnswer.value = widget.option4;
                }
              }, 
              index: '4', 
              selected: clicked, 
              showAnswer: showAnswer,
            ),

            SizedBox(height: Spacing.mediumSpacing),
            Center(
              child: GestureDetector(
                onTap: () {
                  if(QuestionController.to.selectedAnswer.value != ''){
                    if(!QuestionController.to.showAnswer.value){
                      QuestionController.to.checkAnswer();
                      sub.pause();
                      setState(() {
                        showAnswer = true;
                      });
                    }else{
                      Navigator.pop(context);
                      // QuestionController.to.clearQuestionValue();
                    }
                  }else if(QuestionController.to.showAnswer.value){
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: Spacing.smallSpacing, vertical: Spacing.mediumSpacing),
                  decoration: BoxDecoration(
                    color: (QuestionController.to.showAnswer.value) ? Colors.black87 : Colors.blueGrey.shade200,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child:  Obx(() => Text((!QuestionController.to.showAnswer.value) ? 'Konfirmasi Jawaban' : 'Tutup',
                      style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(
                          fontFamily: 'Scada',
                          fontSize: smallText,
                          fontWeight: FontWeight.w700,
                          color: (!QuestionController.to.showAnswer.value) ? plainBlackBackground : Colors.white
                        ),
                    ))
                  )
                ),
              )
            ),
            SizedBox(height: Spacing.smallSpacing),
            Obx(() => extraWidget())
          ],
        ),
      ),
    );
  }

  extraWidget(){
    if(QuestionController.to.showAnswer.value == true){
      return Obx(() => Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(QuestionController.to.animation.value,
              repeat: false,
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
            ),
            Text(QuestionController.to.answerCorrect.value ? 'JAWABAN BENAR' : 'JAWABAN SALAH',
              style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w600,
                  fontSize: averageText,
                  color: QuestionController.to.answerCorrect.value ? Colors.green.shade300 : Colors.red
                ),
            )
          ],
        )
      ));
    }else{
      return Obx(() => Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing, horizontal: Spacing.mediumSpacing),
          decoration: BoxDecoration(
            color: Colors.brown.shade300,
            border: Border.all(color: Colors.brown.shade600, width: 2),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Waktu: ',
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w400,
                    fontSize: smallText,
                    color: Colors.black87
                  ),
              ),
              Text('${QuestionController.to.curTime.value}',
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontWeight: FontWeight.w700,
                    fontSize: averageText,
                    color: (QuestionController.to.curTime.value > 5) ? Colors.black : Colors.red.shade300
                  ),
              ),
            ],
          ),
        ),
      ));
    }
  }
}