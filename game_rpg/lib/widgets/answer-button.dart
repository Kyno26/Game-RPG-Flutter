import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/question-controller.dart';
import 'package:get/get.dart';

class AnswerButton extends StatefulWidget{
  
  final String textAnswer;
  final VoidCallback onPressed;
  final String index;
  final String selected;
  final bool showAnswer;

  const AnswerButton({super.key, required this.textAnswer, required this.onPressed, required this.index, required this.selected, required this.showAnswer});

  @override
  State<AnswerButton> createState() => _AnswerButtonState();
}

class _AnswerButtonState extends State<AnswerButton> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        padding: EdgeInsets.all(Spacing.smallSpacing),
        decoration: BoxDecoration(
          color: (widget.selected != widget.index) 
            ? Colors.white 
            : (!widget.showAnswer) 
              ? Colors.green.shade200 
              : (widget.textAnswer != QuestionController.to.correctAnswer.value) 
                ? redColor 
                : Colors.green.shade700,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: (widget.selected != widget.index) 
              ? Colors.black12 
              : (!widget.showAnswer)
                ? Colors.green.shade400
                : (widget.textAnswer != QuestionController.to.correctAnswer.value)
                  ? Colors.red.shade300
                  : Colors.green.shade200
            , width: 3)
        ),
        child:  Text(widget.textAnswer,
          style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(
              fontFamily: 'Scada',
              fontSize: smallText,
              fontWeight: FontWeight.w400,
              color: (widget.selected != widget.index)
                ? plainBlackBackground
                : (!widget.showAnswer)
                  ? plainBlackBackground
                  : Colors.white
            ),
        ),
      )
    );
  }
}