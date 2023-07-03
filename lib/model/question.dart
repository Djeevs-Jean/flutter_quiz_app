import 'dart:math';
import 'package:flutter/material.dart';


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

class CategoryQuestion {
  final String name;
  final IconData iconData;
  final String description;

  CategoryQuestion({required this.name, required this.iconData,
    required this.description,
  });
}

/* class QuizResult {
  final int id; // Identifiant unique
  final String quizTitle;
  final double score;
  final int countQuestion;
  final DateTime date;

  QuizResult({required this.id, required this.quizTitle, required this.score, required this.date, required this.countQuestion});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizTitle': quizTitle,
      'score': score,
      'date':date.toIso8601String(),
      'countQuestion': countQuestion,
    };
  }

  factory QuizResult.fromMap(Map<String, dynamic> map) {
    return QuizResult(
      id: map['id'],
      quizTitle: map['quizTitle'],
      score: map['score'],
      date: DateTime.parse(map['date']),
      countQuestion: map['countQuestion'],
    );
  }
} */
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
    final sanitizedTitle = _sanitizeString(quizTitle);
    final scoreString = score.toString();
    return '$sanitizedTitle-$scoreString';
  }

  static String _sanitizeString(String input) {
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

/* 
class QuizResult {
  final int? id; // Identifiant unique
  final String quizTitle;
  final double score;
  final int countQuestion;
  final DateTime date;

  QuizResult({this.id, required this.quizTitle, required this.score, required this.date, required this.countQuestion});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quizTitle': quizTitle,
      'score': score,
      'date': date.toIso8601String(),
      'countQuestion': countQuestion,
    };
  }

  factory QuizResult.fromMap(Map<String, dynamic> map) {
    return QuizResult(
      id: map['id'],
      quizTitle: map['quizTitle'],
      score: map['score'],
      date: DateTime.parse(map['date']),
      countQuestion: map['countQuestion'],
    );
  }
}
 */


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