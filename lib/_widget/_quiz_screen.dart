import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/_widget/_widget_question.dart';
import 'package:flutter_quiz/screens/end_quiz.dart';
import 'package:flutter_quiz/model/model.dart';
import 'package:flutter_quiz/main.dart'; // Importez le fichier contenant MainScreen

class QuizzesPresentation extends StatefulWidget {
  final QuizPresentModel quizPresentModel; 
  final List<Question> questions;

  const QuizzesPresentation({ Key? key, required this.quizPresentModel, required this.questions, }) : super(key: key);

  @override
  State<QuizzesPresentation> createState() => _QuizzesPresentationState();
}



class _QuizzesPresentationState extends State<QuizzesPresentation> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  bool showCorrectAnswer = false;
  bool showNextButton = false;
  double progress = 0.0;

  void checkAnswer() {
    int correctAnswerIndex =
        widget.questions[currentQuestionIndex].correctAnswerIndex;
    if (selectedAnswerIndex == correctAnswerIndex) {
      score++;
    }
    showCorrectAnswer = true;
    showNextButton = true;
    setState(() {});
  }

  void showNextQuestion() {
    selectedAnswerIndex = null;
    showCorrectAnswer = false;
    showNextButton = false;
    progress = (currentQuestionIndex + 1) / widget.questions.length;

    if (currentQuestionIndex < widget.questions.length - 1) {
      currentQuestionIndex++;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            score: score,
            totalQuestions: widget.questions.length,
            titleQuiz: widget.quizPresentModel.quizTitle,
          ),
        ),
      );
    }
    setState(() {});
  }

  Future<bool?> _confirmExitQuiz() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quit Quiz'),
        content: Text('Are you sure you want to quit the quiz? Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () => {},
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    bool? shouldPop = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Voulez-vous vraiment quitter le quiz ? Vos modifications seront perdues.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false); // L'utilisateur choisit de ne pas quitter
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // L'utilisateur choisit de quitter
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (shouldPop == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }

    return Future.value(shouldPop ?? false); // Retourne false par défaut si la boîte de dialogue est fermée sans sélection
  }

  double getScorePercentage() {
    double percentage = (score / widget.questions.length) * 100;
    return percentage;
  }

  Future<void> pauseAndContinue() async {
    await Future.delayed(const Duration(seconds: 2));
    showNextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
        ),
        body: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.all(10),
          child: widget.questions.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LinearProgressIndicator(
                      value: progress,
                      color: Colors.blue,
                      backgroundColor: Colors.pink,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Question ${currentQuestionIndex + 1}/${widget.questions.length}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    QuestionSingle(
                      question: widget.questions[currentQuestionIndex],
                      selectedAnswerIndex: selectedAnswerIndex,
                      showCorrectAnswer: showCorrectAnswer,
                      onAnswerSelected: (index) {
                        setState(() {
                          selectedAnswerIndex = index;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    if (!showNextButton)
                      ElevatedButton(
                        onPressed: selectedAnswerIndex == null || showCorrectAnswer
                            ? null
                            : () {
                                checkAnswer();
                              },
                        child: const Text('Check Answer'),
                      ),
                    const SizedBox(height: 16),
                    if (showNextButton)
                      ElevatedButton(
                        onPressed: () {
                          showNextQuestion();
                        },
                        child: const Text('Next Question'),
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
        ),
        ),
      ),
    );
  }
}