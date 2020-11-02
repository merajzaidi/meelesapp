import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meeles/screens/updatemenu_screen.dart';
import 'package:intl/intl.dart';

class MenuWidget extends StatelessWidget {
  static const routeName = '/cardvariant';
  static const id = 'CardVariant';
  String getday;
  String today = DateFormat('EEEEE', 'en_US').format(DateTime.now());
  var currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference daymenu;
  MenuWidget({this.getday});

  @override
  Widget build(BuildContext context) {
    final heightOne = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Mess')
              .doc(currentuser.email)
              .collection('Other Details')
              .doc('Menu')
              .collection(getday)
              .snapshots(includeMetadataChanges: true),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> menushot) {
            if (menushot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (menushot.data.docs.isEmpty)
              return new ListView(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Updatemenu.routeName);
                    },
                    child: Card(
                      elevation: 8.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        height: heightOne * 0.33,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Center(
                              child: Chip(
                                label: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    'Lunch',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Center(
                              child: Text(
                                'Create Your Menu',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(Updatemenu.routeName);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Updatemenu.routeName);
                    },
                    child: Card(
                      elevation: 8.0,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        height: heightOne * 0.33,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Center(
                              child: Chip(
                                label: Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(
                                    'Dinner',
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Text(
                                'Create Your Menu',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(Updatemenu.routeName);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Create',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            return ListView(
              children:
                  menushot.data.docs.map((QueryDocumentSnapshot document) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Updatemenu.routeName);
                  },
                  child: new Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      height: heightOne * 0.33,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Chip(
                              label: Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  document.data()['type'],
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      'https://cdn.pixabay.com/photo/2016/12/26/17/28/food-1932466__340.jpg',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                          '${document.data()['Item1']}  ${document.data()['Item2']}  ${document.data()['Item3']}  ${document.data()['Item4']}  Roti\'s : ${document.data()['Roti Quantity']}  ${document.data()['Rice Type']}  ${document.data()['Desert']}'),
                                      Text(
                                          'Price: ${document.data()['Price']}'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Updatemenu.routeName);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Update',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
