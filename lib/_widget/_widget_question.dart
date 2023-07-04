import 'package:flutter/material.dart';
import 'package:flutter_quiz/model/model.dart';


class QuestionSingle extends StatelessWidget {
  final Question question;
  final int? selectedAnswerIndex;
  final bool showCorrectAnswer;
  final Function(int) onAnswerSelected;

  const QuestionSingle({
    Key? key,
    required this.question,
    required this.selectedAnswerIndex,
    required this.showCorrectAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              question.question,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              final optionText = question.options[index];
              bool isCorrectAnswer = index == question.correctAnswerIndex;
              bool isSelectedAnswer = index == selectedAnswerIndex;

              return GestureDetector(
                onTap: () {
                  if (!showCorrectAnswer) {
                    onAnswerSelected(index);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: showCorrectAnswer
                        ? isCorrectAnswer
                            ? Colors.green.withOpacity(0.5)
                            : isSelectedAnswer
                                ? Colors.red.withOpacity(0.5)
                                : null
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RadioListTile<int>(
                    title: Text(
                      optionText,
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelectedAnswer
                            ? Colors.blue
                            : showCorrectAnswer && isCorrectAnswer
                                ? Colors.green
                                : null,
                      ),
                    ),
                    value: index,
                    groupValue: selectedAnswerIndex,
                    onChanged: (value) {
                      if (!showCorrectAnswer) {
                        onAnswerSelected(value ?? 0);
                      }
                    },
                    activeColor: Colors.blue, // Couleur du bouton radio sélectionné
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}