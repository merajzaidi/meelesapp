import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Meeles_Partner/screens/updatemenu_screen.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class MenuWidget extends StatefulWidget {
  static const routeName = '/cardvariant';
  static const id = 'CardVariant';
  String getday;
  MenuWidget({this.getday});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  String endlunch, enddinner, typeinstant, typecapacity;

  int typeinstanceseat;

  String today = DateFormat('EEEEE', 'en_US').format(DateTime.now());

  var currentuser = FirebaseAuth.instance.currentUser;

  CollectionReference daymenu;

  bool isopen;

  var bookingstatus = true;

  File pickedimage;

  @override
  Widget build(BuildContext context) {
    final heightOne = MediaQuery.of(context).size.height;
    File _image;
    final picker = ImagePicker();
    String _uploadFileURL;
    CollectionReference imgColRef = FirebaseFirestore.instance
        .collection('Mess')
        .doc(currentuser.email)
        .collection('Other Details')
        .doc('Menu')
        .collection(widget.getday);

    Future<void> retrieveLostData() async {
      final LostData response = await picker.getLostData();
      if (response.isEmpty) {
        return;
      }
      if (response.file != null) {
        setState(() {
          _image = File(response.file.path);
        });
      } else {
        print(response.file);
      }
    }

    Future chooseImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(pickedFile.path);
      });

      if (pickedFile.path == null) retrieveLostData();
    }

    Future uploadFile(String type) async {
      var storageReference = FirebaseStorage.instance
          .ref()
          .child('meal_images/${Path.basename(_image.path)}');

      UploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.whenComplete(() => null);
      print('file uploaded');

      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadFileURL = fileURL;
        });
      }).whenComplete(() async {
        await imgColRef.doc(type).update({'url': _uploadFileURL});
        print('link added to database');
      });
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Mess')
              .doc(currentuser.email)
              .collection('Other Details')
              .doc('Menu')
              .collection(widget.getday)
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
                      height: heightOne * 0.39,
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
                              Column(
                                children: [
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: document.data()['url'] == null
                                            ? NetworkImage(
                                                'https://cdn.pixabay.com/photo/2016/12/26/17/28/food-1932466__340.jpg',
                                              )
                                            : NetworkImage(
                                                document.data()['url']),
                                      ),
                                    ),
                                  ),
                                  FlatButton.icon(
                                    onPressed: () {
                                      chooseImage().whenComplete(() {
                                        uploadFile(document.data()['type']);
                                      });
                                    },
                                    textColor: Theme.of(context).primaryColor,
                                    icon: Icon(Icons.image),
                                    label: Text('Update Photo'),
                                  ),
                                ],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Row(
                                children: [
                                  Text(
                                    'Booking',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Lato',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Switch(value: bookingstatus, onChanged: null),
                                ],
                              )),
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
