// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/model/basic_question.dart';
import 'package:game_rpg/widgets/question-display/question-basic.dart';
import 'package:get/get.dart';
import 'package:quiver/async.dart';

class QuestionController extends GetxController{
  static QuestionController get to => Get.find<QuestionController>();

  RxString question = ''.obs;
  RxString answerOption1 = ''.obs;
  RxString answerOption2 = ''.obs;
  RxString answerOption3 = ''.obs;
  RxString answerOption4 = ''.obs;
  RxString correctAnswer = ''.obs;
  RxString selectedAnswer = ''.obs;
  RxBool answerCorrect = false.obs;

  BasicQuestion? selectedQuestion;
  RxString animation = ''.obs;
  RxBool showAnimation = false.obs;

  RxInt maxTime = 20.obs;
  RxInt curTime = 20.obs;

  RxInt currentScore = 0.obs;
  RxBool newScore = false.obs;

  var showAnswer = false.obs;

  clearQuestionValue() {
    question.value = '';
    answerOption1.value = '';
    answerOption2.value = '';
    answerOption3.value = '';
    answerOption4.value = '';
    correctAnswer.value = '';
    selectedAnswer.value = '';
    showAnswer.value = false;
    showAnimation.value = false;
    maxTime.value = 20;
    curTime.value = 20;
  }

  getQuestionFromDatabase() async {
    int min = 1;
    List tableList = ['question_respiration', 'question_digestive', 'question_immune'];
    String tableName = '';

    if(BattleFieldController.to.storyRound.value <= 5){
      tableName = 'question_respiration';
    }else if(BattleFieldController.to.storyRound.value > 5 && BattleFieldController.to.storyRound.value <= 10){
      tableName = 'question_digestive';
    }else if(BattleFieldController.to.storyRound.value > 10 && BattleFieldController.to.storyRound.value <= 15){
      tableName = 'question_immune';
    }else{
      var tableId = Random().nextInt(tableList.length);
      tableName = tableList[tableId];
    }
    
    int max = await DBManager.db.getCount(tableName: tableName);

    var questionID = Random().nextInt(max - min + 1) + min;
    selectedQuestion = await DBManager.db.getQuestion(idQuestion: questionID, tableName: tableName);
    
    question.value = selectedQuestion!.question;
    randomizeChoiceOption();
    correctAnswer.value = selectedQuestion!.answer;
  }

  randomizeChoiceOption() {
    var min = 1;
    var max = 4;
    var selectedPosition = Random().nextInt(max - min + 1) + min;
    print(selectedPosition);
    switch (selectedPosition) {
      case 1:
        answerOption1.value = selectedQuestion!.option1;
        answerOption2.value = selectedQuestion!.option2;
        answerOption3.value = selectedQuestion!.option3;
        answerOption4.value = selectedQuestion!.option4;
        break;
      case 2:
        answerOption2.value = selectedQuestion!.option1;
        answerOption1.value = selectedQuestion!.option2;
        answerOption4.value = selectedQuestion!.option3;
        answerOption3.value = selectedQuestion!.option4;
        break;
      case 3:
        answerOption4.value = selectedQuestion!.option1;
        answerOption2.value = selectedQuestion!.option2;
        answerOption1.value = selectedQuestion!.option3;
        answerOption3.value = selectedQuestion!.option4;
        break;
      case 4:
        answerOption4.value = selectedQuestion!.option1;
        answerOption3.value = selectedQuestion!.option2;
        answerOption2.value = selectedQuestion!.option3;
        answerOption1.value = selectedQuestion!.option4;
        break;
      default:
        print('default int for question');
        answerOption1.value = selectedQuestion!.option1;
        answerOption2.value = selectedQuestion!.option2;
        answerOption3.value = selectedQuestion!.option3;
        answerOption4.value = selectedQuestion!.option4;
        break;
    }
  }

  showQuestion({required BuildContext context}) async {
    await getQuestionFromDatabase();
    BattleFieldController.to.turnIcon.value = 'assets/icons/player-turn-icon.svg';
    BattleFieldController.to.questionPhase.value = true;
    BattleFieldController.to.turn.value = 'Pemain';
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (context){
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: QuestionBasic(
            question: question.value, 
            option1: answerOption1.value, 
            option2: answerOption2.value, 
            option3: answerOption3.value, 
            option4: answerOption4.value
          )
        );
      } 
    );
  }

  startTimer(){
    CountdownTimer countdownTimer = CountdownTimer(
      Duration(seconds: maxTime.value), 
      const Duration(seconds: 1)
    );
    var sub = countdownTimer.listen((event) {
      
    });
    sub.onData((duration) {
      curTime.value = maxTime.value - duration.elapsed.inSeconds;
    });
    sub.onDone(() {
      checkAnswer();
      sub.cancel();
    });
  }

  checkAnswer<Bool>() {
    var answer = false;
    if(selectedAnswer == correctAnswer){
      answer = true;
      currentScore.value = currentScore.value + BattleFieldController.to.scorePerQuestion.value;
      answerCorrect.value = true;
      animation.value = 'assets/images/lottie/correct-answer.json';
    }else{
      answer = false;
      answerCorrect.value = false;
      animation.value = 'assets/images/lottie/wrong-answer.json';
    }
    print(answer);
    print('Current Score: ${currentScore.value}');
    showAnswer.value = true;
    showAnimation.value = true;

    BattleFieldController.to.questionPhase.value = false;
    Timer(const Duration(seconds: 1), (){
      showAnimation.value = false;
    });
    return answer;
  }
}