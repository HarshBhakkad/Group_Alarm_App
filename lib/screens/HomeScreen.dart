import 'package:alarm_app/AlarmCard.dart';
import 'package:alarm_app/screens/CreateAlarm.dart';
import 'package:alarm_app/screens/GroupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'GroupPage.dart';

class home_screen extends StatefulWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  // @override
  // Future<void> addData() async {
  //   globals.alarm_cards = [];
  //   await FirebaseFirestore.instance
  //       .collection('alarms')
  //       .where('user', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       globals.alarm_cards.add(alarm_card(
  //         hour: element.data()['hour'],
  //         minute: element.data()['minute'],
  //       ));
  //     });
  //   });
  //   setState(() {
  //     globals.alarm_cards.sort((a, b) {
  //       if (a.hour == b.hour) {
  //         return a.minute.compareTo(b.minute);
  //       }
  //       return a.hour.compareTo(b.hour);
  //     });
  //   });
  // }

  @override
  Future<void> addAlarms() async {
    globals.alarm_cards = [];
    await globals.users
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      value['alarm_cards'].forEach((element) {
        globals.alarm_cards
            .add(alarm_card(hour: element['hour'], minute: element['minute']));
      });
    });
    setState(() {
      globals.alarm_cards.sort((a, b) {
        if (a.hour == b.hour) {
          return a.minute.compareTo(b.minute);
        }
        return a.hour.compareTo(b.hour);
      });
      Set<int> hours = Set<int>();
      Set<int> minutes = Set<int>();
      globals.alarm_cards = globals.alarm_cards.where((element) {
        if (hours.contains(element.hour) && minutes.contains(element.minute)) {
          return false;
        } else {
          hours.add(element.hour);
          minutes.add(element.minute);
          return true;
        }
      }).toList();
    });
  }

  void initState() {
    globals.alarm_cards.clear();
    super.initState();

    addAlarms();
  }

  @override
  Widget build(BuildContext context) {
    // addData();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Alarm App'),
          actions: <Widget>[
            IconButton(
              highlightColor: Colors.transparent,
              icon: Icon(Icons.people),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => groupPage(),
                  ),
                );
              },
            ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print(globals.alarm_cards);
            globals.alarm_cards = [];
            print(globals.alarm_cards);
            await FirebaseAuth.instance.signOut();
          },
          child: Icon(Icons.logout),
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
