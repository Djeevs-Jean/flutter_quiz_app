import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_quiz/model/model.dart';

class ServiceQuizResult {
  static const String key = 'quiz_results';

  Future<void> saveQuizResult(QuizResult quizResult) async {
    final prefs = await SharedPreferences.getInstance();
    final quizResults = await getQuizResults();
    quizResults.add(quizResult);
    await prefs.setStringList(key, quizResults.map((result) => jsonEncode(result)).toList());
  }


  Future<List<QuizResult>> getQuizResults() async {
    final prefs = await SharedPreferences.getInstance();
    final resultsJson = prefs.getStringList(key);
    if (resultsJson != null) {
      return resultsJson.map((json) => QuizResult.fromJson(jsonDecode(json))).toList();
    }
    return [];
  }

   Future<void> deleteQuizResult(QuizResult quizResult) async {
    final prefs = await SharedPreferences.getInstance();
    final quizResults = await getQuizResults();
    for (var result in quizResults) {
      print('Quiz result ID: ${result.id}');
    }
    quizResults.removeWhere((result) => result.id == quizResult.id);
    await prefs.setStringList(
      key,
      quizResults.map((result) => jsonEncode(result)).toList(),
    );
  }

}
