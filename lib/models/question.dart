enum QuestionType {
  mcq,
  fillBlank,
  output,
}

class Question {
  final QuestionType type;

  final String question;

  final String? code;

  final List<String>? options;

  final int? correctOption;

  final String? answer;

  final String explanation;

  const Question({
    required this.type,
    required this.question,
    this.code,
    this.options,
    this.correctOption,
    this.answer,
    required this.explanation,
  });
}