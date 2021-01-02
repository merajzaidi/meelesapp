import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Orders extends StatelessWidget {
  String type;
  var date;
  Orders({this.type, this.date});

  @override
  Widget build(BuildContext context) {
    var obj = FirebaseFirestore.instance
        .collection('Mess')
        .doc(FirebaseAuth.instance.currentUser.email)
        .collection('Booking')
        .doc(date);
    var booking = obj.collection(type);
    var booking_instant = obj.collection('$type Instant');
    return SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: booking_instant.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('Loading...'),
                );
              }

              return new ListView(
                shrinkWrap: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new ListTile(
                    leading: Image.network(document.data()['Photo']),
                    title: new Text(document.data()['Name']),
                    subtitle: new Text(
                        'Payment Mode : ${document.data()['Payment Mode']}'),
                    trailing: document.data()['Food Taken']
                        ? Icon(Icons.check_circle)
                        : Icon(Icons.circle),
                  );
                }).toList(),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: booking.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return new ListView(
                shrinkWrap: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new ListTile(
                    leading: Image.network(document.data()['Photo']),
                    title: new Text(document.data()['Name']),
                    subtitle: new Text(
                        'Payment Mode : ${document.data()['Payment Mode']}'),
                    trailing: document.data()['Food Taken']
                        ? Icon(Icons.check_box_outlined)
                        : Icon(Icons.check_box_outline_blank_sharp),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
