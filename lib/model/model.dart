
class Question {
  String? category;
  String question;
  List<String> options;
  int correctAnswerIndex;

  Question({this.category, required this.question, required this.options, required this.correctAnswerIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      category: json['category'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correctAnswerIndex'],
    );
  }
}

class QuizResult {
  final String id; // Identifiant unique
  final String quizTitle;
  final double score;
  final int countQuestion;
  final DateTime date;

  QuizResult({
    required this.quizTitle,
    required this.score,
    required this.date,
    required this.countQuestion,
  }) : id = _generateId(quizTitle, score);

  static String _generateId(String quizTitle, double score) {
    final sanitizedTitle = _regexString(quizTitle);
    final scoreString = score.toString();
    return '$sanitizedTitle-$scoreString';
  }

  static String _regexString(String input) {
    final sanitized = input.replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '-');
    return sanitized.toLowerCase();
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      quizTitle: json['quizTitle'],
      score: json['score'],
      countQuestion: json['countQuestion'],
      date: DateTime.parse(json['date']),
    );
  }

  factory QuizResult.fromMap(Map<String, dynamic> map) {
    return QuizResult(
      // id: map['id'],
      quizTitle: map['quizTitle'],
      score: map['score'],
      countQuestion: map['countQuestion'],
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizTitle': quizTitle,
      'score': score,
      'countQuestion': countQuestion,
      'date': date.toIso8601String(),
    };
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quizTitle': quizTitle,
      'score': score,
      'countQuestion': countQuestion,
      'date': date.toIso8601String(),
    };
  }
}

class QuestionModel {
  String quizTitle;
  String file;
  String image;

  QuestionModel({required this.quizTitle, required this.file, required this.image});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      quizTitle: json['quizTitle'],
      file: json['file'],
      image: json['image'],
    );
  }
}