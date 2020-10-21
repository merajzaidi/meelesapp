import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class Days {
  final String day;

  const Days({
    @required this.day,
  });
}

const Weekdays = const [
  Days(
    day: 'Sunday',
  ),
  Days(
    day: 'Monday',
  ),
  Days(
    day: 'Tuesday',
  ),
  Days(
    day: 'Wednesday',
  ),
  Days(
    day: 'Thrusday',
  ),
  Days(
    day: 'Friday',
  ),
  Days(
    day: 'Saturday',
  ),
];

class Menu with ChangeNotifier {
  String weekday = '';
  String mealtime = 'Lunch';
  String mealtype = 'Veg';
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore menuObject = FirebaseFirestore.instance;
  //Map<String, dynamic> messname = Auth().data;
  Future<void> dayweek(String dayy) {
    weekday = dayy;
    notifyListeners();
    return null;
  }

  Future<void> timing(String time) {
    mealtime = time;
    notifyListeners();
    return null;
  }

  Future<void> type(String typee) {
    mealtype = typee;
    return null;
  }

  Future<bool> addmenu(data) async {
    // String date = new DateTime.now().toString();
    await menuObject
        .collection('MessDetails')
        .doc(auth.currentUser.displayName)
        .collection(auth.currentUser.uid)
        .doc('Menu')
        .collection(weekday)
        .doc(mealtime)
        .set({
      'Item1': data['item1'],
      'Item2': data['item2'],
      'Item3': data['item3'],
      'Item4': data['item4'],
      'Roti Quantity': data['roti'],
      'Rice Type': data['rice'],
      'Desert': data['desert'],
      'Price': data['price'],
    }).then((_) {
      return true;
    }).catchError((e) {
      print(e);
      return false;
    });
    return true;
  }

  get lunch {
    menuObject
        .collection('MessDetails')
        .doc(auth.currentUser.displayName)
        .collection(auth.currentUser.uid)
        .doc('Menu')
        .collection(weekday)
        .doc(mealtime)
        .get()
        .then((DocumentSnapshot document) {
      if (document.exists) {
        return document.data();
      } else
        return false;
    });
  }
}
