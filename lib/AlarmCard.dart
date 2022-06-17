import 'package:flutter/material.dart';

class alarm_card extends StatelessWidget {
  int hour = 0;
  int minute = 0;

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
