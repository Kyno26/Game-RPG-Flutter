class BasicQuestion {
  late final int id;
  late final String question;
  late final String option1;
  late final String option2;
  late final String option3;
  late final String option4;
  late final String answer;

  BasicQuestion.empty();

  BasicQuestion({
    required this.id,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.answer,
  });

  factory BasicQuestion.fromMap(Map<String, dynamic> json) {
    return BasicQuestion(
      id: json['id'], 
      question: json['question'], 
      option1: json['option1'], 
      option2: json['option2'], 
      option3: json['option3'], 
      option4: json['option4'], 
      answer: json['correct_answer'],
    );
  }

  Map<String, dynamic> toMap ()=> {
    'id': id,
    'question': question,
    'option1': option1,
    'option2': option2,
    'option3': option3,
    'option4': option4,
    'correct_answer': answer,
  };
}