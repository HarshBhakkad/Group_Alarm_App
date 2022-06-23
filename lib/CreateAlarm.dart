import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'globals.dart' as globals;
import 'AlarmCard.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

class create_alarm extends StatefulWidget {
  const create_alarm({Key? key}) : super(key: key);

  @override
  State<create_alarm> createState() => _create_alarmState();
}

class _create_alarmState extends State<create_alarm> {
  TextEditingController _hour_controller = TextEditingController(text: '23');
  TextEditingController _minute_controller = TextEditingController(text: '59');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text('Alarm App'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: TextFormField(
                            controller: _hour_controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Hours',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: TextFormField(
                            controller: _minute_controller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Minutes',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Center(
                    child: ElevatedButton(
                      child: const Text('Create'),
                      onPressed: () {
                        setState(() {
                          FlutterAlarmClock.createAlarm(
                              int.parse(_hour_controller.text),
                              int.parse(_minute_controller.text));
                          globals.alarm_cards.add(
                            alarm_card(
                                hour: int.parse(_hour_controller.text),
                                minute: int.parse(_minute_controller.text)),
                          );
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const home_screen()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
