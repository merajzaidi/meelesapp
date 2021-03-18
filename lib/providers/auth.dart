import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as Path;

class Auth with ChangeNotifier {
  UserCredential authresult;
  bool isregister = true;
  Map<String, dynamic> data;
  var user,phone;
  bool created = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference getmenu = FirebaseFirestore.instance.collection('Mess');
  FirebaseFirestore adddata = FirebaseFirestore.instance;

  Future<void> authlogin(String email, String password) async {
    authresult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    user = auth.currentUser;
    print(authresult);
    notifyListeners();
    return null;
  }
  Future<void> phonelogin(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    ///name = FirebaseAuth.instance.currentUser.displayName;
    notifyListeners();
    return null;
  }

  Future<void> authsignup(String email, String password) async {
    authresult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user = auth.currentUser;
    notifyListeners();
    return null;
  }

  Future<void> authlogout() async {
    await FirebaseAuth.instance.signOut();
    user = null;
    notifyListeners();
  }

      Future uploadFile(_image) async {
        String url;
      var storageReference = FirebaseStorage.instance
          .ref()
          .child('Mess_Images/${Path.basename(_image.path)}');

      UploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.whenComplete(() => null);
      print('file uploaded');

      await storageReference.getDownloadURL().then((fileURL) {
        url = fileURL;
      });
      return url;
    }


  // Future<bool> addinfo(data2) async {
  //   await adddata
  //       .collection('Mess')
  //       .doc(user.displayname)
  //       .collection(user.uid)
  //       .doc('Details')
  //       .update({
  //     'Shop Name': data2['shop_name'],
  //     'Address': data2['address'],
  //     'FSSAI NO': data2['fssai'],
  //     'GST NO': data2['gst'],
  //     'Capacity': data2['capacity'],
  //     'Email': user.email,
  //     'Open Whole Day': data2['openwholeday'],
  //     'Monthly Subscription': data2['monthly'],
  //     'Lunch Begining': data2['lunch_start'],
  //     'Lunch End': data2['lunch_end'],
  //     'Dinner Starting': data2['dinner_start'],
  //     'Dinner End': data2['dinner_end'],
  //   }).then((_) {
  //     return true;
  //   }).catchError((error) {
  //     print(error);
  //     return false;
  //   });
  //   return true;
  // }

  Future<bool> addpersonal(data, data2, service, isopen, ismonthly,position, _image) async {
    String url = await uploadFile(_image);
    print(data['Landmark']);
    print(data2);
    print(data);
    print('$service  $isopen  $ismonthly');
    await adddata.collection('Mess').doc(auth.currentUser.phoneNumber).set({
      'Owner Name': data2['Name'],
      'Permanent Address': data2['permanent_address'],
      'Pincode': data2['pincode'],
      'City': data2['city'],
      'Landmark': data['Landmark'],
      'Phone no.': auth.currentUser.phoneNumber,
      'Adhar Card': data2['adharcard'],
      'Shop Name': data['shop_name'],
      'Address': data['address'],
      'FSSAI NO': data['fssai'],
      'GST NO': data['gst'],
      'Capacity': data['capacity'],
      'Email': data2['Email'],
      'Service Type': service,
      'Open Whole Day': isopen,
      'Monthly Subscription': ismonthly,
      'Lunch Begining': data['lunch_start'],
      'Lunch End': data['lunch_end'],
      'Dinner Starting': data['dinner_start'],
      'Dinner End': data['dinner_end'],
      'coordinates': GeoPoint(position.latitude,position.longitude),
      'note1': data['note1'],
      'note2': data['note2'],
      'note3': data['note3'],
      'note4': data['note4'],
      'Rating': 3.0,
      'Verified': false,
      'url': url,
    }).then((value) async {
      await auth.currentUser.updateProfile(displayName: data2['Name'],);
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
    notifyListeners();
    return true;
  }

  Future<void> addmenu(String val) async {
    await adddata
        .collection('Mess')
        .doc(auth.currentUser.phoneNumber)
        .collection('Other Details')
        .doc('Menu')
        .set({
          'Menu': 'Yes',
        })
        .then((value) => true)
        .catchError((onError) => false);
  }

  bool get isAuth {
    if (auth.currentUser == null)
      return false;
    else
      return true;
  }

  CollectionReference get snapshot {
    return getmenu;
  }

  bool get isregisteration{
    if(auth.currentUser.displayName =='' || auth.currentUser.displayName == null)
      return false;
    else return true;
  }
  void messphone(ph){
    phone = ph;
    notifyListeners();
  }
  get messmobile {
    return phone;
  }
}
