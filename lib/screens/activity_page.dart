import 'package:flutter_quiz/model/question.dart';
import 'package:flutter_quiz/service/service_sharepreferences.dart';
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
    print('Deleting quiz result with ID: ${quizResult.id}');
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
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizResultDetailPage(quizResult: quizResult),
                    ),
                  );
                },
                child: Card(
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
} */

// class _ActivityTabState extends State<ActivityTab> {
//   late Future<List<QuizResult>> _quizResultsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _quizResultsFuture = fetchQuizResults();
//   }

//   Future<List<QuizResult>> fetchQuizResults() async {
//     final quizResultData = QuizResultStorage();
//     List<QuizResult> quizResults = await quizResultData.getQuizResults();
//     return quizResults.reversed.toList();
//   }

//   void deleteQuizResult(QuizResult quizResult) async {
//     print('Deleting quiz result with ID: ${quizResult.id}');
//     final quizResultData = QuizResultStorage();
//     await quizResultData.deleteQuizResult(quizResult);

//     setState(() {
//       _quizResultsFuture = fetchQuizResults();
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<QuizResult>>(
//       future: fetchQuizResults(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(
//               color: Colors.purple,
//               strokeWidth: 6,
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'Error: ${snapshot.error}',
//               style: TextStyle(
//                 color: Colors.red,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           );
//         } else if (snapshot.hasData) {
//           final quizResults = snapshot.data!;
//           return ListView.builder(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//             itemCount: quizResults.length,
//             itemBuilder: (context, index) {
//               final quizResult = quizResults[index];
//               return Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ListTile(
//                   title: Text(
//                     'activityname'.tr() + ' : ${quizResult.quizTitle}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.deepPurple,
//                     ),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.score,
//                             color: Colors.amber,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Score: ${quizResult.score}%',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.date_range,
//                             color: Colors.blue,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             'Date: ${DateFormat('MMM d, h:mm a').format(quizResult.date)}',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 4),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.question_answer,
//                             color: Colors.green,
//                           ),
//                           SizedBox(width: 4),
//                           Text(
//                             '${quizResult.countQuestion} questions',
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (context) => AlertDialog(
//                           title: Text('Delete Quiz Result'),
//                           content: Text('Are you sure you want to delete this quiz result?'),
//                           actions: [
//                             TextButton(
//                               child: Text('Cancel'),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                             ),
//                             TextButton(
//                               child: Text('Delete'),
//                               onPressed: () {
//                                 deleteQuizResult(quizResult);
//                                 Navigator.pop(context);
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           return Center(
//             child: Text(
//               'No quiz results found.',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }


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


// mélangées de manière aléatoire les options de réponse pour  chaque question.
