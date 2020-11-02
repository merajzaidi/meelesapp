import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

class Auth with ChangeNotifier {
  UserCredential authresult;
  bool isregister = true;
  Map<String, dynamic> data;
  var user;
  bool created = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference getmenu = FirebaseFirestore.instance.collection('Mess');
  FirebaseFirestore adddata = FirebaseFirestore.instance;
  Future<void> authlogin(String email, String password) async {
    authresult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    user = auth.currentUser;
    isregister = true;
    print(authresult);
    notifyListeners();
    return null;
  }

  Future<void> authsignup(String email, String password) async {
    authresult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = auth.currentUser;
    isregister = false;
    notifyListeners();
    return null;
  }

  Future<void> authlogout() async {
    await FirebaseAuth.instance.signOut();
    user = null;
    notifyListeners();
  }

  Future<bool> addinfo(data2) async {
    await adddata
        .collection('Mess')
        .doc(user.displayname)
        .collection(user.uid)
        .doc('Details')
        .update({
      'Shop Name': data2['shop_name'],
      'Address': data2['address'],
      'FSSAI NO': data2['fssai'],
      'GST NO': data2['gst'],
      'Capacity': data2['capacity'],
      'Email': user.email,
      'Open Whole Day': data2['openwholeday'],
      'Monthly Subscription': data2['monthly'],
      'Lunch Begining': data2['lunch_start'],
      'Lunch End': data2['lunch_end'],
      'Dinner Starting': data2['dinner_start'],
      'Dinner End': data2['dinner_end'],
    }).then((_) {
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
    return true;
  }

  Future<bool> addpersonal(data, data2, service, isopen, ismonthly) async {
    user.updateProfile(displayName: data2['Name']);
    print(data['Landmark']);
    print(data2);
    print(data);
    print('$service  $isopen  $ismonthly');
    await adddata.collection('Mess').doc(user.email).set({
      'Owner Name': data2['Name'],
      'Permanent Address': data2['permanent_address'],
      'Pincode': data2['pincode'],
      'City': data2['city'],
      'Landmark': data['Landmark'],
      'Phone no.': data2['phone'],
      'Adhar Card': data2['adharcard'],
      'Shop Name': data['shop_name'],
      'Address': data['address'],
      'FSSAI NO': data['fssai'],
      'GST NO': data['gst'],
      'Capacity': data['capacity'],
      'Email': user.email,
      'Service Type': service,
      'Open Whole Day': isopen,
      'Monthly Subscription': ismonthly,
      'Lunch Begining': data['lunch_start'],
      'Lunch End': data['lunch_end'],
      'Dinner Starting': data['dinner_start'],
      'Dinner End': data['dinner_end'],
    }).then((value) {
      return true;
    }).catchError((error) {
      return false;
    });
    isregister = true;
    notifyListeners();
    return true;
  }

  Future<void> addmenu(String val) async {
    await adddata
        .collection('Mess')
        .doc(user.email)
        .collection('Other Details')
        .doc('Menu')
        .set({
          'Menu': 'Yes',
        })
        .then((value) => true)
        .catchError((onError) => false);
  }

  bool get isAuth {
    if (auth.currentUser == null || isregister == false)
      return false;
    else
      return true;
  }

  CollectionReference get snapshot {
    return getmenu;
  }
}
