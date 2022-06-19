import 'package:alarm_app/AlarmCard.dart';
import 'package:alarm_app/CreateAlarm.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Alarm App'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const create_alarm()),
                );
              },
            )
          ],
        ),
        body: globals.alarm_cards.isEmpty
            ? NoAlarm()
            : SingleChildScrollView(
                child: Column(
                  children: globals.alarm_cards
                      .map((alarm_card) => alarm_card)
                      .toList(),
                ),
              ),
      ),
    );
  }
}
