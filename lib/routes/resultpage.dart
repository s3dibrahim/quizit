import 'package:flutter/material.dart';
import 'home.dart';

class ResultPage extends StatefulWidget {
  final int marks;
  final int totalQuestions;
  ResultPage({@required this.marks, @required this.totalQuestions});
  @override
  _ResultPageState createState() => _ResultPageState(marks,totalQuestions);
}

class _ResultPageState extends State<ResultPage> {

  List<String> images = [
    "images/success.png",
    "images/good.png",
    "images/bad.png",
  ];

  String message;
  String image;

  @override
  void initState(){
    double percent = marks / total * 100;
    String percentStr = percent.toStringAsFixed(2);
    if(percent < 50){
      image = images[2];
      message = "You Should Try Hard..\n" "You Scored $percentStr";
    }else if(percent < 75){
      image = images[1];
      message = "You Can Do Better..\n" "You Scored $percentStr";
    }else{
      image = images[0];
      message = "You Did Very Well..\n" "You Scored $percentStr";
    }
    super.initState();
  }

  int marks;
  int total;
  _ResultPageState(this.marks,this.total);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      child: Center(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Quando",
                        ),
                      ),
                    )
                    ),
                  ],
                ),
              ),
            ),            
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  },
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}