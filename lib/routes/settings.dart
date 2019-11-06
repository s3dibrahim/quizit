import 'package:Quizit/utils/preferences.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _showAnswer = false;
  
  _loadSettings() async {
    _showAnswer = await Preferences().getBool('showAnswer') ?? false;
    setState(() {});
  }

  _onShowSettings(bool val) {
    setState(() => _showAnswer = val);
    Preferences().setBool('showAnswer', val);
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('Show answer'),
                trailing: Switch(
                  value: _showAnswer,
                  onChanged: (val) => _onShowSettings(val),
                ),
              ),
            )
          ],
        ));
  }
}
