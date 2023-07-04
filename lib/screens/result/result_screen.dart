import 'package:flutter/material.dart';
import 'package:flutter_quiz/model/question.dart';
import 'package:flutter_quiz/main.dart';
import 'package:flutter_quiz/service/service_sharepreferences.dart';
import 'package:flutter_quiz/adapter/crud_hive.dart';

import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String titleQuiz;

  const ResultScreen({Key? key, required this.score, required this.totalQuestions, required this.titleQuiz})  : super(key: key);

  void saveScore(int count) async {
    final scores = double.parse(getScorePercentage().toStringAsFixed(1));

    final quizResult = QuizResult(
      quizTitle: titleQuiz,
      score: scores,
      date: DateTime.now(),
      countQuestion: count,
    );

    final quizResultData = ServiceQuizResult();
    await quizResultData.saveQuizResult(quizResult);
  }

  double getScorePercentage() {
    double percentage = (score / totalQuestions) * 100;
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    saveScore(totalQuestions);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Results',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.workspaces,
              color: Colors.green,
              size: 80,
            ),
            SizedBox(height: 24),
            Text(
              'Quiz Completed!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Your score: $score / $totalQuestions',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Equivalent: ${getScorePercentage().toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.home,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Go to Home',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String titleQuiz;

  const ResultScreen({Key? key, required this.score, required this.totalQuestions, required this.titleQuiz})  : super(key: key);

  void saveScore(int count) async {
    final scores = double.parse(getScorePercentage().toStringAsFixed(1));

    final quizResult = QuizResult(
      quizTitle: titleQuiz,
      score: scores,
      date: DateTime.now(),
      countQuestion: count,
    );

    final quizResultData = QuizResultStorage();
    await quizResultData.saveQuizResult(quizResult);

  }
  double getScorePercentage() {
    double percentage = (score / totalQuestions) * 100;
    return percentage;
  }

  @override
  Widget build(BuildContext context) {
    saveScore(totalQuestions);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Your score: $score / $totalQuestions',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Equivalent: ${getScorePercentage().toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 20),
            ),
            
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                  (route) => false,
                );
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
 */