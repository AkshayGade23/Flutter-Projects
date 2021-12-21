import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetHandler;

  String get resultPhrase {
    var resultText;
    if (totalScore <= 14) {
      resultText = 'You Are Awesome!!';
    } else if (totalScore <= 18) {
      resultText = 'You Are Nice!!';
    } else if (totalScore <= 20) {
      resultText = 'You Are Good!!';
    } else {
      resultText = 'You Are Danger!!';
    }

    return resultText;
  }

  Result({this.totalScore, this.resetHandler});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          FlatButton(
              child: Text(
                'Reset Quiz!',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: resetHandler)
        ],
      ),
    );
  }
}
