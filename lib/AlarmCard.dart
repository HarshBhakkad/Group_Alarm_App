import 'package:flutter/material.dart';
import 'package:alarm_app/CreateAlarm.dart';
import 'dart:async';
import 'package:alarm_app/globals.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';

class alarm_card extends StatefulWidget {
  int hour = 0;
  int minute = 0;

  alarm_card({this.hour = 23, this.minute = 59});

  @override
  State<alarm_card> createState() => _alarm_cardState();
}

class _alarm_cardState extends State<alarm_card> {
  var dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.alarm),
            title: Text('Alarm'),
            subtitle: Text('${widget.hour}:${widget.minute}'),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  setState(() {
                    globals.alarm_cards.remove(this);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Snooze'),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NoAlarm extends StatefulWidget {
  NoAlarm({Key? key}) : super(key: key);

  @override
  State<NoAlarm> createState() => _NoAlarmState();
}

class _NoAlarmState extends State<NoAlarm> {
  @override
  DateTime dt = DateTime.now();
  String hour = "";
  String minute = "";
  String second = "";
  void setTime() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        dt = DateTime.now();
        hour = dt.hour.toString();
        if (hour.length == 1) {
          hour = "0" + hour;
        }
        minute = dt.minute.toString();
        if (minute.length == 1) {
          minute = "0" + minute;
        }
        second = dt.second.toString();
        if (second.length == 1) {
          second = "0" + second;
        }
        setTime();
      });
    });
  }

  void initState() {
    super.initState();
    // Timer.periodic(Duration(seconds: 1), (Timer t) {
    //   setState(() {
    //     dt = DateTime.now();
    //   });
    // });
    setTime();
  }

  Widget build(BuildContext context) {
    setTime();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {},
              child: Text(
                '${hour}:${minute}',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No Alarms',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Create Alarm'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const create_alarm()),
                );
              },
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: Center(
                child: ElevatedButton(
                  child: const Text('Log Out'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
