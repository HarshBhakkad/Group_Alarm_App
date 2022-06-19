import 'package:flutter/material.dart';
import 'package:alarm_app/CreateAlarm.dart';

class alarm_card extends StatelessWidget {
  int hour = 0;
  int minute = 0;
  var dt = DateTime.now();
  alarm_card({this.hour = 23, this.minute = 59});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.alarm),
            title: Text('Alarm'),
            subtitle: Text('$hour:$minute'),
          ),
          ButtonBar(
            children: [
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {},
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
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
