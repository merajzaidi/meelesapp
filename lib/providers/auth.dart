import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

// class Auth with ChangeNotifier {
//   String _token;
//   DateTime _expiryDate;
//   String _userId;
//   Timer _authTimer;

//   bool get isAuth {
//     return token != null;
//   }

//   String get token {
//     if (_expiryDate != null &&
//         _expiryDate.isAfter(DateTime.now()) &&
//         _token != null) {
//       return _token;
//     }
//     return null;
//   }

//   String get userId {
//     return _userId;
//   }

//   Future<void> _authenticate(
//       String email, String password, String urlSegment) async {
//     final url =
//         'https://tytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBqa6STo3hwBgx7kahkPT0QVYOHAXcCnqA';
//     try {
//       final response = await http.post(
//         url,
//         body: json.encode(
//           {
//             'email': email,
//             'password': password,
//             'returnSecureToken': true,
//           },
//         ),
//       );
//       final responseData = json.decode(response.body);
//       if (responseData['error'] != null) {
//         throw HttpException(responseData['error']['message']);
//       }
//       _token = responseData['idToken'];
//       _userId = responseData['NavigationBarBottomlocalId'];
//       _expiryDate = DateTime.now().add(
//         Duration(
//           seconds: int.parse(
//             responseData['expiresIn'],
//           ),
//         ),
//       );
//       _autoLogout();
//       notifyListeners();
//       final prefs = await SharedPreferences.getInstance();
//       final userData = json.encode(
//         {
//           'token': _token,
//           'userId': _userId,
//           'expiryDate': _expiryDate.toIso8601String(),
//         },
//       );
//       prefs.setString('userData', userData);
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<void> signup(String email, String password) async {
//     return _authenticate(email, password, 'signUp');
//   }

//   Future<void> login(String email, String password) async {
//     return _authenticate(email, password, 'signInWithPassword');
//   }

//   Future<bool> tryAutoLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userData')) {
//       return false;
//     }
//     final extractedUserData =
//         json.decode(prefs.getString('userData')) as Map<String, Object>;
//     final expiryDate = DateTime.parse(extractedUserData['expiryDate']);
//     if (expiryDate.isBefore(DateTime.now())) {
//       return false;
//     }
//     _token = extractedUserData['token'];
//     _userId = extractedUserData['userId'];
//     _expiryDate = expiryDate;
//     notifyListeners();
//     _autoLogout();
//     return true;
//   }

//   Future<void> logout() async {
//     _token = null;
//     _userId = null;
//     _expiryDate = null;
//     if (_authTimer != null) {
//       _authTimer.cancel();
//       _authTimer = null;
//     }
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }

//   void _autoLogout() {
//     if (_authTimer != null) {
//       _authTimer.cancel();
//     }
//     final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
//     _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
//   }
// }
class Auth with ChangeNotifier {
  UserCredential authresult;
  bool isregister = false;
  Map<String, dynamic> data;
  var user;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference getmenu;
  FirebaseFirestore adddata = FirebaseFirestore.instance;
  Future<void> authlogin(String email, String password) async {
    authresult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    user = FirebaseAuth.instance.currentUser;
    getmenu = FirebaseFirestore.instance
        .collection('MessDetails')
        .doc(user.displayName)
        .collection(user.uid);
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
    notifyListeners();
  }

  Future<bool> addinfo(data2) async {
    await adddata
        .collection('MessDetails')
        .doc(user.displayName)
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

  Future<bool> addpersonal(data) async {
    user.updateProfile(displayName: data['Landmark']);
    print(auth.currentUser.displayName);
    await adddata
        .collection('MessDetails')
        .doc(data['Landmark'])
        .collection(user.uid)
        .doc('Details')
        .set({
      'Owner Name': data['Name'],
      'Permanent Address': data['permanent_address'],
      'Pincode': data['pincode'],
      'City': data['city'],
      'Landmark': data['Landmark'],
      'Phone no.': data['phone'],
      'Adhar Card': data['adharcard'],
    }).then((value) {
      return true;
    }).catchError((error) {
      return false;
    });
    return true;
  }

  Future<void> addmenu() async {
    await adddata
        .collection('MessDetails')
        .doc(user.displayName)
        .collection(user.uid)
        .doc('Menu')
        .update({
          'Menu': 'Yes',
        })
        .then((value) => true)
        .catchError((onError) => false);
  }

  bool get isAuth {
    if (user == null)
      return false;
    else
      return true;
  }

  CollectionReference get snapshot {
    return getmenu;
  }
}
