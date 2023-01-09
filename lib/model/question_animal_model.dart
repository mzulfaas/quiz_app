class QuestionAnimalModel {
  String? question;
  String? imageUrl;
  List<String>? answers;
  String? correctAnswer;
  int? questionNumber;

  QuestionAnimalModel(
      {this.question,
        this.imageUrl,
        this.answers,
        this.correctAnswer,
        this.questionNumber});

  QuestionAnimalModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    imageUrl = json['imageUrl'];
    answers = json['answers'].cast<String>();
    correctAnswer = json['correctAnswer'];
    questionNumber = json['questionNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['imageUrl'] = this.imageUrl;
    data['answers'] = this.answers;
    data['correctAnswer'] = this.correctAnswer;
    data['questionNumber'] = this.questionNumber;
    return data;
  }
}
