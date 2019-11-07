import 'package:Quizit/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'home.dart';
import 'resultpage.dart';
import '../utils/singleGesture.dart';

class QuizPage extends StatefulWidget {
  final quizData;
  QuizPage({@required this.quizData});

  @override
  _QuizPageState createState() => _QuizPageState(quizData);
}

class _QuizPageState extends State<QuizPage> {
  List quizData;
  _QuizPageState(this.quizData);

  static Color defaultColor = Colors.indigoAccent;
  Color btnColor = defaultColor;
  int marks = 0;
  int timer;
  int index = 0;

  Map<String, Color> btnColorMap;

  bool _answerChecked = false;
  bool _showAnswer = false;

  void _resetTimer() {
    timer = 15;
  }

  void _resetButtonsColor() {
    btnColorMap = {
      "a": defaultColor,
      "b": defaultColor,
      "c": defaultColor,
      "d": defaultColor,
    };
  }

  _loadSettings() async {
    _showAnswer = await Preferences().getBool('showAnswer') ?? false;
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _resetButtonsColor();
    _resetTimer();
    _startTimer();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _startTimer() async {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (_answerChecked == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
      });
    });
  }

  void nextQuestion() {
    _answerChecked = false;
    _resetTimer();
    setState(() {
      if (index < quizData.length - 1) {
        index++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              ResultPage(marks: marks, totalQuestions: quizData.length),
        ));
      }
      _resetButtonsColor();
    });
    _startTimer();
  }

  void _checkAnswer(String selectedAnswer) {
    if (!_answerChecked) {
      String correctAnswer = quizData[index]['answer'];
      bool wrongAnswer = false;
      if (selectedAnswer == correctAnswer) {
        marks++;
        btnColor = Colors.green;
      } else {
        btnColor = Colors.red;
        wrongAnswer = true;
      }
      setState(() {
        btnColorMap[selectedAnswer] = btnColor;
        if (wrongAnswer && _showAnswer) {
          btnColorMap[correctAnswer] = Colors.green;
        }
        _answerChecked = true;
      });

      Timer(Duration(seconds: 1), nextQuestion);
    }
  }

  Widget choiceButton(String choice) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => _checkAnswer(choice),
        child: Text(
          quizData[index][choice],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btnColorMap[choice],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Quizit"),
                  content: Text("Do you want to stop the current quiz?"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text('Yes'),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('No'),
                    )
                  ],
                ));
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                alignment: Alignment.bottomLeft,
                child: Text(
                  quizData[index]['question'],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Quando",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: SingleTouchWidget(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choiceButton('a'),
                      choiceButton('b'),
                      choiceButton('c'),
                      choiceButton('d'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    timer.toString(),
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
