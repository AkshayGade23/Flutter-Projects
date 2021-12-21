import 'package:first_app/quiz.dart';
import 'package:first_app/result.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText': 'What\'s Your Favorite Color',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'White', 'score': 1},
        {'text': 'Red', 'score': 7},
        {'text': 'Grren', 'score': 3},
      ],
    },
    {
      'questionText': 'What\'s Your Favorite Animal',
      'answers': [
        {'text': 'Lion', 'score': 13},
        {'text': 'Cat', 'score': 3},
        {'text': 'Dog', 'score': 1},
        {'text': 'Tiger', 'score': 12},
      ],
    },
    {
      'questionText': 'What\'s Your Favorite Food',
      'answers': [
        {'text': 'PuranPoli', 'score': 1},
        {'text': 'PaneerKadhai', 'score': 7},
        {'text': 'Misal', 'score': 9},
        {'text': 'PavBhaji', 'score': 11},
      ],
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex++;
      print(_questionIndex);

      if (_questionIndex < _questions.length) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Akshay"),
          ),
          body: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                )
              : Result(
                  totalScore: _totalScore,
                  resetHandler: _resetQuiz,
                )),
    );
  }
}
