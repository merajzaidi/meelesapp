import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Orders extends StatelessWidget {
  String type;
  var date;
  Orders({this.type, this.date});

  @override
  Widget build(BuildContext context) {
    var booking = FirebaseFirestore.instance
        .collection('Mess')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('Other Details')
        .doc('Booking')
        .collection(date)
        .where('Type', isEqualTo: type);
    return StreamBuilder<QuerySnapshot>(
      stream: booking.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              leading: Image.network(document.data()['Photo']),
              title: new Text(document.data()['Name']),
              subtitle:
                  new Text('Payment Mode : ${document.data()['Payment Mode']}'),
              trailing: new Text('60'),
            );
          }).toList(),
        );
      },
    );
  }
}
