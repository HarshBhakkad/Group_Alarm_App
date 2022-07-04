import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:alarm_app/globals.dart' as globals;
import 'package:firebase_auth/firebase_auth.dart';

class group_info extends StatefulWidget {
  // const group_info({Key? key}) : super(key: key);
  // add a constructor which adds the group code
  @override
  String grpcode = '';
  String? Admin = '';
  group_info(String gc) {
    grpcode = gc;
    // check if there is a user as admin of this group
    Admin = FirebaseAuth.instance.currentUser?.email;

    globals.grps.doc(grpcode).set({
      'grpcode': grpcode,
      'Admin': Admin,
      'members': [],
    });

    List<String?> members = [Admin];
    globals.users.get().then((value) => value.docs.forEach((element) {
          if (element['grpids'].contains(grpcode)) {
            members.add(element.id);
            globals.grps.doc(grpcode).update({
              'members': members,
            });
          }
        }));
  }
  @override
  State<group_info> createState() => _group_infoState();
}

class _group_infoState extends State<group_info> {
  TextEditingController email_controller = TextEditingController();

  @override
  List<String> members = [];
  getMemebers() async {
    members = [];
    await globals.grps.doc(widget.grpcode).get().then((value) {
      setState(() {
        members = List.from(value['members']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Info - ${widget.grpcode}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Admin: ${widget.Admin}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: TextFormField(
                      controller: email_controller,
                      decoration: InputDecoration(
                        labelText: 'Email ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                var exists =
                    await globals.users.doc(email_controller.text).get();

                if (exists.exists) {
                  print('user exists');
                  await globals.grps.doc(widget.grpcode).update({
                    'members': FieldValue.arrayUnion([email_controller.text]),
                  });
                } else {
                  print('User does not exist');
                }
                setState(() {
                  getMemebers();
                  globals.users.doc(email_controller.text).update({
                    'grpids': FieldValue.arrayUnion([widget.grpcode]),
                  });
                  email_controller.clear();
                });
              },
              child: Text('Add Member'),
            ),
            ElevatedButton(
              onPressed: () async {
                final snackBar = SnackBar(
                  content: const Text('User does not exist'),
                  duration: Duration(seconds: 1),
                );
                var exists =
                    await globals.users.doc(email_controller.text).get();

                if (exists.exists) {
                  print('user exists');
                  await globals.grps.doc(widget.grpcode).update({
                    'members': FieldValue.arrayRemove([email_controller.text]),
                  });
                } else {
                  print('User does not exist');
                }
                setState(() {
                  getMemebers();
                  globals.users.doc(email_controller.text).update({
                    'grpids': FieldValue.arrayRemove([widget.grpcode]),
                  });
                  email_controller.clear();
                });
              },
              child: Text('Remove Member'),
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    getMemebers();
                  },
                  child: Text('Members'),
                ),
                Column(
                  children: members
                      .map((e) => Text(e))
                      .toList(), // convert to list to make it scrollable
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
