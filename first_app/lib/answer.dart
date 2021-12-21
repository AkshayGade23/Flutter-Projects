import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandlder;
  final String answers;

  Answer(this.selectHandlder, this.answers);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(answers),
        onPressed: selectHandlder,
      ),
    );
  }
}
