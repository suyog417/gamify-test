class QuestionsModel {
  String? questionId;
  String? questionText;
  String? option1Text;
  String? option2Text;
  String? option3Text;
  String? option4Text;
  String? correctAnswer;
  String? totalCoins;

  QuestionsModel(
      {this.questionId,
        this.questionText,
        this.option1Text,
        this.option2Text,
        this.option3Text,
        this.option4Text,
        this.correctAnswer,
        this.totalCoins});

  QuestionsModel.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    questionText = json['question_text'];
    option1Text = json['option1_text'];
    option2Text = json['option2_text'];
    option3Text = json['option3_text'];
    option4Text = json['option4_text'];
    correctAnswer = json['correct_answer'];
    totalCoins = json['total_coins'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['question_text'] = questionText;
    data['option1_text'] = option1Text;
    data['option2_text'] = option2Text;
    data['option3_text'] = option3Text;
    data['option4_text'] = option4Text;
    data['correct_answer'] = correctAnswer;
    data['total_coins'] = totalCoins;
    return data;
  }
}
