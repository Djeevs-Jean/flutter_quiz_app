import 'package:flutter/material.dart';
import 'package:flutter_quiz/model/model.dart';
import 'package:flutter_quiz/main.dart';
import 'package:flutter_quiz/service/service_sharepreferences.dart';

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
