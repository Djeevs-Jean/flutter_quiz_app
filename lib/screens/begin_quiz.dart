import 'dart:math';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quiz/_widget/_quiz_screen.dart';
import 'package:flutter_quiz/model/model.dart';


class QuestionSelectionPage extends StatefulWidget {
  final QuizPresentModel questionModel;

  QuestionSelectionPage({
    required this.questionModel,
  });

  @override
  _QuestionSelectionPageState createState() => _QuestionSelectionPageState();
}


class _QuestionSelectionPageState extends State<QuestionSelectionPage> {
  double _selectedQuestion = 10.0;
  List<Question> questions = [];
  static String filePath = 'assets/languages/';
  int maxQuestionCount = 11;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    String data = await DefaultAssetBundle.of(context).loadString('$filePath${widget.questionModel.file}.json');
    List<dynamic> jsonData = json.decode(data);
    questions = jsonData.map((item) => Question.fromJson(item)).toList();
    questions.shuffle(Random());

    setState(() {
      maxQuestionCount = questions.length;
    });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonDisabled = _selectedQuestion == 0 || _selectedQuestion > maxQuestionCount;

    return Scaffold(
      appBar: AppBar(
        title: Text('quizname'.tr()  +'- ${widget.questionModel.quizTitle}'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Expanded(
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.5,
                child: SizedBox(
                // height: 120, // Hauteur souhaitée
                child: Card(
                  color: Colors.blue.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    child: Text('indexquiz'.tr(),style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              ),
            ),

            SizedBox(height: 15,),

            Center(child: Text(_selectedQuestion.toInt().toString())),

            SizedBox(height: 15,),

            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.blue,
                inactiveTrackColor: Colors.grey,
                thumbColor: Colors.blue,
                overlayColor: Colors.blue.withOpacity(0.3),
                valueIndicatorColor: Colors.blue,
              ),
              child: Slider(
                value: _selectedQuestion,
                min: 0,
                max: maxQuestionCount.toDouble(),
                divisions: maxQuestionCount,
                label: _selectedQuestion.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _selectedQuestion = value;
                  });
                },
              ),
            ),

          const Spacer(),
            ElevatedButton(
              onPressed: isButtonDisabled
                  ? null
                  : () {
                      var selectedQuestions = questions.sublist(0, _selectedQuestion.toInt());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizzesPresentation(
                            quizPresentModel: widget.questionModel,
                            questions: selectedQuestions,
                          ),
                        ),
                      );
                    }, style: ElevatedButton.styleFrom(
                primary: isButtonDisabled ? Colors.grey : Colors.blue,
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
                    Icons.play_arrow,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'btnstartquiz'.tr().toString(),
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