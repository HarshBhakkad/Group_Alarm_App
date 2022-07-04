library globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'AlarmCard.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

CollectionReference grps = FirebaseFirestore.instance.collection('groups');
CollectionReference users = FirebaseFirestore.instance.collection('users');

List<alarm_card> alarm_cards = [];
