import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../providers/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> _initialdata = {
      'Name': '',
      'permanent_address': '',
      'phone': '',
      'adharcard': '',
      'city': '',
      'pincode': '',
    };
    final _formkey = GlobalKey<FormState>();
    Future<void> submit() async {
      if (!_formkey.currentState.validate())
        print('invalid');
      else {
        _formkey.currentState.save();
        final issaved = await Provider.of<Auth>(context, listen: false)
            .addpersonal(_initialdata);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personel details',
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _initialdata['Name'],
                  decoration: InputDecoration(
                    labelText: 'Owner Name',
                    icon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['Name'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['permanent_address'],
                  //focusNode: nodes[0],
                  decoration: InputDecoration(
                    labelText: 'Permanent Address',
                    icon: Icon(Icons.add_location_sharp),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    print(val);
                    _initialdata['permanent_address'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['pincode'],
                  //focusNode: nodes[1],
                  decoration: InputDecoration(
                    labelText: 'Pincode',
                    icon: Icon(Icons.place),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                    if (value.length != 6) return 'Invalid Pincode';
                  },
                  onSaved: (val) {
                    _initialdata['pincode'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['city'],
                  //focusNode: nodes[3],
                  decoration: InputDecoration(
                    labelText: 'City',
                    icon: Icon(Icons.place),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['city'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['adharcard'],
                  decoration: InputDecoration(
                    labelText: 'Adhar Card No.',
                    icon: Icon(Icons.format_list_numbered_outlined),
                    border: OutlineInputBorder(),
                  ),
                  //focusNode: nodes[4],
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                    if (value.length != 12) return 'Invalid Adhar No.';
                  },
                  onSaved: (val) {
                    _initialdata['adharcard'] = val;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['phone'],
                  maxLength: 10,
                  //focusNode: nodes[6],
                  decoration: InputDecoration(
                    labelText: 'Phone No.',
                    icon: Icon(Icons.phone),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['phone'] = val;
                  },
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text('Create Profile'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: submit,
                    elevation: 5,
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
