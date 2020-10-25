import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String weekday;
  String mealtime = 'Lunch';
  String mealtype = 'Veg';
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore menuObject = FirebaseFirestore.instance;
  Future<void> dayweek(String dayy) {
    weekday = dayy;
    return null;
  }

  Future<void> type(String typee) {
    mealtype = typee;
    notifyListeners();
    return null;
  }

  Future<bool> addmenu(data) async {
    // String date = new DateTime.now().toString();
    print(mealtime);
    await menuObject
        .collection('MessDetails')
        .doc(auth.currentUser.displayName)
        .collection(auth.currentUser.uid)
        .doc('Menu')
        .collection(weekday)
        .doc(data['type'])
        .set({
      'Item1': data['item1'],
      'Item2': data['item2'],
      'Item3': data['item3'],
      'Item4': data['item4'],
      'Roti Quantity': data['roti'],
      'Rice Type': data['rice'],
      'Desert': data['desert'],
      'Price': data['price'],
      'type': data['type'],
      'Food_Type': data['thali_type'],
    }).then((_) {
      return true;
    }).catchError((e) {
      print(e);
      return false;
    });
    return true;
  }

  String get getday {
    return weekday;
  }
}
