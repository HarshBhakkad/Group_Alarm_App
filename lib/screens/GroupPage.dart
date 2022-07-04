import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alarm_app/globals.dart' as globals;
import 'dart:math';
import 'GroupInfo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class groupPage extends StatefulWidget {
  const groupPage({Key? key}) : super(key: key);

  @override
  State<groupPage> createState() => _groupPageState();
}

class _groupPageState extends State<groupPage> {
  @override
  List<String> grpids = [];
  TextEditingController grpcode_controller = TextEditingController();
  String grpButton = 'Join Group';

  getdata() async {
    await globals.users
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      setState(() {
        grpids = List.from(value['grpids']);
        grpids = grpids.toSet().toList();
      });
    });
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Page'),
      ),
      body: Center(
        child: // Create a group here
            // Create a group button in a column.
            Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Create a new group'),
              onPressed: () {
                String groupcode = generateRandomString(6);
                // Navigator.push(context, route)
                // FirebaseAuth.instance.currentUser?
                globals.users
                    .doc(FirebaseAuth.instance.currentUser?.email)
                    .update({
                  'grpids': FieldValue.arrayUnion([groupcode])
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => group_info(groupcode),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: TextFormField(
                controller: grpcode_controller,
                decoration: InputDecoration(
                  labelText: 'Group Code',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              child: Text(grpButton),
              onPressed: () {
                globals.grps.doc(grpcode_controller.text).get().then((value) {
                  if (value.exists) {
                    globals.users
                        .doc(FirebaseAuth.instance.currentUser?.email)
                        .update({
                      'grpids': FieldValue.arrayUnion([grpcode_controller.text])
                    });
                    globals.grps.doc(grpcode_controller.text).update({
                      'members': FieldValue.arrayUnion(
                          [FirebaseAuth.instance.currentUser?.email])
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            group_info(grpcode_controller.text),
                      ),
                    );
                  } else {
                    setState(() {
                      grpButton = 'Group does not exist';
                    });
                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        grpButton = 'Join Group';
                      });
                    });
                  }
                });
              },
            ),
            TextButton(
                child: Text('My Groups'),
                onPressed: () {
                  getdata();
                }),
            Column(
              children: grpids.map((grpcode) {
                return TextButton(
                  child: Text('$grpcode'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => group_info(grpcode),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
