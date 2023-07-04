import 'package:flutter/material.dart';
import 'package:flutter_quiz/_widget/_index_quiz_widget.dart';
import 'package:flutter_quiz/model/model.dart';
import 'dart:convert';

class QuizzesTab extends StatefulWidget {
  const QuizzesTab({Key? key}) : super(key: key);

  @override
  State<QuizzesTab> createState() => _QuizzesTabState();
}

class _QuizzesTabState extends State<QuizzesTab> {
  List<QuestionModel> questionsModel = [];
  static String filePath = 'assets/conf/conf.json';

  @override
  void initState() {
    super.initState();
    loadQuestionsModel();
  }

  void loadQuestionsModel() async {
    String data = await DefaultAssetBundle.of(context).loadString(filePath);
    List<dynamic> jsonData = json.decode(data);
    questionsModel = jsonData.map((item) => QuestionModel.fromJson(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: questionsModel.length,
      itemBuilder: (context, index) {
        final qmodel = questionsModel[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuestionSelectionPage(questionModel: qmodel),),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    image: DecorationImage(image: AssetImage(qmodel.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(qmodel.quizTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          SizedBox(width: 4),
                          Text(qmodel.quizTitle.toString(), style: TextStyle(color: Colors.white),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}