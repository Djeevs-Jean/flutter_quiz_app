import 'dart:convert';
import 'dart:io';
import 'package:flutter_quiz/model/model.dart';

class QuizResultDatabase {
  static String filePath = 'assets/data/data.json';

  static Future<void> saveQuizResult(QuizResult quizResult) async {
    List<Map<String, dynamic>> data = [];
    File file = File(filePath);

    if (await file.exists()) {
      String fileContent = await file.readAsString();
      data = json.decode(fileContent).cast<Map<String, dynamic>>();
    }

    data.add(quizResult.toMap());
    await file.writeAsString(jsonEncode(data));
  }

  static Future<List<QuizResult>> loadQuizResults() async {
    List<QuizResult> quizResults = [];
    File file = File(filePath);

    if (await file.exists()) {
      String fileContent = await file.readAsString();
      List<dynamic> data = jsonDecode(fileContent);
      final ddata = data.reversed;
      quizResults = ddata.map((result) => QuizResult.fromMap(result)).toList();
    }

    return quizResults;
  }
}
