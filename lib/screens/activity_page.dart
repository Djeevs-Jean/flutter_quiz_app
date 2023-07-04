import 'package:flutter_quiz/model/model.dart';
import 'package:flutter_quiz/service/service_sharepreferences.dart';
// import 'package:flutter_quiz/adapter/crud_hive.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityTab extends StatefulWidget {
  const ActivityTab({Key? key}) : super(key: key);

  @override
  State<ActivityTab> createState() => _ActivityTabState();
}

class _ActivityTabState extends State<ActivityTab> {
  late Future<List<QuizResult>> _quizResultsFuture;

  @override
  void initState() {
    super.initState();
    _quizResultsFuture = fetchQuizResults();
  }

  Future<List<QuizResult>> fetchQuizResults() async {
    final quizResultData = ServiceQuizResult();
    List<QuizResult> quizResults = await quizResultData.getQuizResults();
    return quizResults.reversed.toList();
  }

  void deleteQuizResult(QuizResult quizResult) async {
    final quizResultData = ServiceQuizResult();
    await quizResultData.deleteQuizResult(quizResult);
    setState(() {
      _quizResultsFuture = fetchQuizResults();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuizResult>>(
      future: _quizResultsFuture,
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
          if (quizResults.isEmpty) {
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
          } else {
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
                            '${'score'.tr().toString()}: ${quizResult.score}%',
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
                          Text('${'date'.tr().toString()}: ${DateFormat('MMM d, h:mm a').format(quizResult.date)}',
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
                            '${quizResult.countQuestion} ${'question'.tr().toString()}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete Quiz Result'),
                          content: Text('Are you sure you want to delete this quiz result?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                deleteQuizResult(quizResult);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
          }
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

class QuizResultDetailPage extends StatelessWidget {
  final QuizResult quizResult;

  const QuizResultDetailPage({required this.quizResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Title: ${quizResult.quizTitle}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Score: ${quizResult.score}%',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Date: ${DateFormat('MMM d, h:mm a').format(quizResult.date)}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Number of Questions: ${quizResult.countQuestion}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

