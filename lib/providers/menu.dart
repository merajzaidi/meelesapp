import 'package:Meeles_Partner/components/globalvariables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';

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
    day: 'Thursday',
  ),
  Days(
    day: 'Friday',
  ),
  Days(
    day: 'Saturday',
  ),
];

class Menu with ChangeNotifier {
  String weekday = DateFormat('EEEEE', 'en_US').format(DateTime.now());
  String mealtime = 'Lunch';
  String mealtype = 'Veg';
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore menuObject = FirebaseFirestore.instance;
  Stream document = FirebaseFirestore.instance
      .collection('Mess')
      .doc(FirebaseAuth.instance.currentUser.email)
      .snapshots();
  List meals = ['Lunch', 'Lunch Instant', 'Dinner', 'Dinner Instant'];
  Map<String, dynamic> data;
  Future<void> dayweek(String dayy) {
    weekday = dayy;
    return null;
  }

  Future<void> type(String typee) {
    mealtype = typee;
    notifyListeners();
    return null;
  }

  Future<bool> addmenu(data, time) async {
    data.addAll({'Prebook Time': time, 'Area': selfdata.mess_landmark, 'url': 'https://firebasestorage.googleapis.com/v0/b/meeles-786110.appspot.com/o/meal_images%2Fimage_picker1381636990.jpg?alt=media&token=8ddc1472-9c52-46a0-b315-33f518662a90'});
    await menuObject
        .collection('Mess')
        .doc(auth.currentUser.phoneNumber)
        .collection('Other Details')
        .doc('Menu')
        .collection(weekday)
        .doc(data['type'])
        .set(
    //       {
    //   'Item1': data['Item1'],
    //   'Item2': data['Item2'],
    //   'Item3': data['Item3'],
    //   'Item4': data['Item4'],
    //   'Roti Quantity': data['Roti Quantity'],
    //   'Rice Type': data['rice'],
    //   'Desert': data['desert'],
    //   'Price': data['price'],
    //   'type': data['type'],
    //   'Food_Type': data['thali_type'],
    //   'Seats': data['seats'],
    //   'Instant': data['instant'],
    //   'Prebook Time': time,
    //   'Area': selfdata.mess_landmark,
    // }
    data
    ).then((_) {
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

  Future updatestatus(id) async {
    int i;
    bool isfind = true;
    var details = FirebaseFirestore.instance
        .collection('Mess')
        .doc(auth.currentUser.phoneNumber)
        .collection('Booking')
        .doc(DateFormat.yMMMMEEEEd().format(DateTime.now()));
    // FirebaseFirestore.instance
    //     .collectionGroup('Booking')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     print(doc["Name"]);
    //   });
    // });
    for (i = 0; i < 4; i++) {
      if (isfind) {
        data = await details
            .collection(meals[i])
            .doc(id)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            print(documentSnapshot.data());
            details
                .collection(documentSnapshot.data()['Type'])
                .doc(id)
                .update({'Food Taken': true}).then((value) {
              print('Updated');
            });
            isfind = false;
            return documentSnapshot.data();
          }
        });
      } else
        break;
    }
    if (isfind)
      return {'error': 'Not Found'};
    else
      return data;
  }
}
