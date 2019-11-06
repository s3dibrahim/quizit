import '../routes/dataLoader.dart';
import 'package:flutter/material.dart';

Widget quizTopicCard(BuildContext context, String topicName, String des) {
  return InkWell(
    onTap: () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => DataLoader(topicName),
      ));
    },
    child: Card(
      color: Colors.indigoAccent,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(100.0),
              child: Container(
                height: 150.0,
                width: 150.0,
                child: ClipOval(
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage('images/$topicName.png'),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              topicName,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: "Quando",
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              des,
              style: TextStyle(
                  fontSize: 18.0, color: Colors.white, fontFamily: "Alike"),
              maxLines: 5,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    ),
  );
}
