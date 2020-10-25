import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  static const id = 'UpdateProfile';
  CollectionReference messprofile;
  DocumentSnapshot data;
  Widget build(BuildContext context) {
    messprofile = Provider.of<Auth>(context).snapshot;
    return FutureBuilder<DocumentSnapshot>(
      future: messprofile.doc('Details').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return AlertDialog(
            title: Text('An Error Occured'),
            content: Text('Something went Wrong'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 30.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['Owner Name'],
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 23.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                data['Email'],
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  color: Colors.blueGrey[200],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: NetworkImage(
                              'https://image.cnbcfm.com/api/v1/image/105773439-1551717349171rtx6p9uc.jpg?v=1551717410',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blueGrey[50],
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Chip(
                              label: Text('Mess Details'),
                              backgroundColor: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                                vertical: 20.0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Mess Name:'),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(data['Shop Name']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      Text('Capacity:'),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(data['Capacity']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      Text('Location:'),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Flexible(
                                        child: Text(data['Address']),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    children: [
                                      Text('Lunch Timing:'),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      Text(
                                          '${data['Lunch Begining']} - ${data['Lunch End']}'),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  FlatButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Proceed for weekly menu updation',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.0,
                                          color: Colors.blue),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {},
                                    child: Text(
                                      'Update Info',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
