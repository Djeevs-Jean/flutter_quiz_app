import 'package:flutter_quiz/model/question.dart';
import 'package:flutter_quiz/sharedprefer/demo.dart';
// import 'package:flutter_quiz/adapter/crud_hive.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_quiz/service/service_json.dart';
import 'package:intl/intl.dart';
class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}
class _ActivityTabState extends State<ActivityTab> {
  Future<List<QuizResult>> fetchQuizResults() async {
    final quizResultData = QuizResultStorage();
    List<QuizResult> quizResults = await quizResultData.getQuizResults();
    return quizResults.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizResult>>(
      future: fetchQuizResults(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
              strokeWidth: 6,
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          final quizResults = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            itemCount: quizResults.length,
            itemBuilder: (context, index) {
              final quizResult = quizResults[index];
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    'activityname'.tr() + ' : ${quizResult.quizTitle}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.score,
                            color: Colors.amber,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Score: ${quizResult.score}%',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Date: ${DateFormat('MMM d, h:mm a').format(quizResult.date)}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.question_answer,
                            color: Colors.green,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${quizResult.countQuestion} questions',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Text(
              'No quiz results found.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
      },
    );
  }
}


/* class _ActivityTabState extends State<ActivityTab> {
 Future<List<QuizResult>> fetchQuizResults() async {
  final quizResultData = QuizResultStorage();
  List<QuizResult> quizResults = await quizResultData.getQuizResults();
  return quizResults.reversed.toList();
}


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizResult>>(
      future: fetchQuizResults(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final quizResults = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            itemCount: quizResults.length,
            itemBuilder: (context, index) {
              final quizResult = quizResults[index];
              return ListTile(
                title: Text(
                  'activityname'.tr() + ' : ${quizResult.quizTitle}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.score),
                        Text('Score: ${quizResult.score}%'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.date_range),
                        // Text('Date: ${quizResult.date}'),
                        Text('Date: ${DateFormat('MMM d, h:mm a').format(quizResult.date)}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.question_answer),
                        Text('${quizResult.countQuestion} questions'),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text('No quiz results found.'),
          );
        }
      },
    );
  }
} */


