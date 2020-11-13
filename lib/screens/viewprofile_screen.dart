import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meeles/screens/registerScreen.dart';
import 'package:meeles/screens/registerprofile_screen.dart';
import 'package:meeles/screens/weeklyMenusScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as Path;

class ProfileView extends StatefulWidget {
  static const id = 'UpdateProfile';

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  DocumentSnapshot data;

  var auth = FirebaseAuth.instance.currentUser;

  File pickedimage;

  Widget build(BuildContext context) {
    // void _pickImage() async {
    //   final pickedImageFile = await ImagePicker().getImage(
    //     source: ImageSource.camera,
    //     imageQuality: 50,
    //     maxWidth: 150,
    //   );
    //   setState(() {
    //     pickedimage = File(pickedImageFile.path);
    //   });
    //   String downloadURL = await firebase_storage.FirebaseStorage.instance
    //   .ref(pickedImageFile.path)
    //   .getDownloadURL();
    // }
    File _image;
    final picker = ImagePicker();
    String _uploadFileURL;
    DocumentReference imgColRef =
        FirebaseFirestore.instance.collection('Mess').doc(auth.email);

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

    Future uploadFile() async {
      var storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${Path.basename(_image.path)}');

      UploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.whenComplete(() => null);
      print('file uploaded');

      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadFileURL = fileURL;
        });
      }).whenComplete(() async {
        await imgColRef.update({'url': _uploadFileURL});
        print('link added to database');
      });
    }

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance.collection('Mess').doc(auth.email).get(),
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
                          Column(
                            children: [
                              CircleAvatar(
                                radius: 35.0,
                                backgroundImage: data['url'] == null
                                    ? NetworkImage(
                                        'https://image.cnbcfm.com/api/v1/image/105773439-1551717349171rtx6p9uc.jpg?v=1551717410')
                                    : NetworkImage(data['url']),
                              ),
                              FlatButton.icon(
                                onPressed: () {
                                  chooseImage().whenComplete(() {
                                    uploadFile();
                                  });
                                },
                                textColor: Theme.of(context).primaryColor,
                                icon: Icon(Icons.image),
                                label: Text('Update Photo'),
                              ),
                            ],
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
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          WeeklyMenuOverviewScreen.routeName);
                                    },
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
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(Profile.routeName);
                                    },
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
