// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/model/basic_question.dart';
import 'package:game_rpg/widgets/question-display/question-basic.dart';
import 'package:get/get.dart';

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
  }

  getQuestionFromDatabase() async {
    int min = 1;
    int max = await DBManager.db.getCount(tableName: 'question');

    var questionID = Random().nextInt(max - min + 1) + min;
    selectedQuestion = await DBManager.db.getQuestion(idQuestion: questionID);
    
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
    BattleFieldController.to.turn.value = 'player';
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

  checkAnswer<Bool>() {
    var answer = false;
    if(selectedAnswer == correctAnswer){
      answer = true;
      currentScore.value = currentScore.value + BattleFieldController.to.scorePerQuestion.value;
      answerCorrect.value = true;
    }else{
      answer = false;
      answerCorrect.value = false;
    }
    print(answer);
    print('Current Score: ${currentScore.value}');
    showAnswer.value = true;

    BattleFieldController.to.questionPhase.value = false;
    // clearQuestionValue();
    return answer;
  }
}