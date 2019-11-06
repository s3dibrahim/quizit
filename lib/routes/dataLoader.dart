import 'package:flutter/material.dart';
import 'dart:convert';
import 'quizpage.dart';

class DataLoader extends StatelessWidget {
  final topicName;
  DataLoader(this.topicName);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/$topicName.json', cache: true),
      builder: (context, snapshot) {
        List response = json.decode(snapshot.data.toString());
        if (response == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading...",
              ),
            ),
          );
        } else {
          return QuizPage(quizData: response);
        }
      },
    );
  }
}