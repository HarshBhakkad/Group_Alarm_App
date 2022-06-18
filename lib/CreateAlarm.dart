import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'globals.dart' as globals;
import 'AlarmCard.dart';

class create_alarm extends StatefulWidget {
  const create_alarm({Key? key}) : super(key: key);

  @override
  State<create_alarm> createState() => _create_alarmState();
}

class _create_alarmState extends State<create_alarm> {
  TextEditingController _hourController = TextEditingController();
  TextEditingController _minuteController = TextEditingController();
  int hours = 23;
  int minutes = 59;
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
                            onChanged: ((value) {
                              hours = int.parse(value);
                            }),
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
                            onChanged: (value) {
                              minutes = int.parse(value);
                            },
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
                          globals.alarm_cards.add(
                            alarm_card(hour: hours, minute: minutes),
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
