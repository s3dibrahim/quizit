import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Quizit/routes/settings.dart';
import 'package:Quizit/widgets/QuizTopicCard.dart';
import '../utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> des = [
    "Python is one of the most popular and fastest programming language since half a decade.\nIf You think you have learnt it.. \nJust test yourself !!",
    "Java has always been one of the best choices for Enterprise World. If you think you have learn the Language...\nJust Test Yourself !!",
    "Javascript is one of the most Popular programming language supporting the Web.\nIt has a wide range of Libraries making it Very Powerful !",
    "C++, being a statically typed programming language is very powerful and Fast.\nit's DMA feature makes it more useful. !",
    "Linux is a OPEN SOURCE Operating System which powers many Servers and Workstation.\nIt is also a top Priority in Developement Work !",
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quizit",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
        //automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings()));
            },
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: utils.exitOnBack,
        child: ListView(
          children: <Widget>[
            quizTopicCard(context, "python", des[0]),
            quizTopicCard(context, "java", des[1]),
            quizTopicCard(context, "js", des[2]),
            quizTopicCard(context, "cpp", des[3]),
            //quizTopicCard(context, "linux", des[4]),
          ],
        ),
      ),
    );
  }
}
