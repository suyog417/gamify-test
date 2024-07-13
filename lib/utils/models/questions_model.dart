class Questions {
  String? questionId;
  String? questionText;
  String? option1Text;
  String? option2Text;
  String? option3Text;
  String? option4Text;
  String? correctAnswer;
  String? totalCoins;

  Questions(
      {this.questionId,
        this.questionText,
        this.option1Text,
        this.option2Text,
        this.option3Text,
        this.option4Text,
        this.correctAnswer,
        this.totalCoins});

  Questions.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question_text'] = this.questionText;
    data['option1_text'] = this.option1Text;
    data['option2_text'] = this.option2Text;
    data['option3_text'] = this.option3Text;
    data['option4_text'] = this.option4Text;
    data['correct_answer'] = this.correctAnswer;
    data['total_coins'] = this.totalCoins;
    return data;
  }
}
