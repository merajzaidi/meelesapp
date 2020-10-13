import 'package:flutter/material.dart';
import 'package:meeles/constants/colorConstants.dart';
import 'package:meeles/widgets/homeScreenDrawer.dart';
import '../widgets/divider.dart';
import 'package:time_range/time_range.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'dart:io';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    Map<String, dynamic> _initialdata = {
      //'image_url': '',
      'shop_name': '',
      'address': '',
      'Landmark': '',
      'fssai': '',
      'gst': '',
      'capacity': '',
      'phone': '',
      'openwholeday': false,
      'monthly': false,
      'lunch_start': '',
      'lunch_end': '',
      'dinner_start': '',
      'dinner_end': '',
    };
    bool _isopen = false;
    bool _ismonthly = false;
    File pickedimage;

    void _pickImage() async {
      final pickedImageFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150,
      );
      setState(() {
        pickedimage = File(pickedImageFile.path);
      });
    }

    Future<void> submit() async {
      if (_formkey.currentState.validate())
        print('invalid');
      else
        _formkey.currentState.save();
      print(_initialdata);
      final issaved =
          await Provider.of<Auth>(context, listen: false).addinfo(_initialdata);
      print(issaved);
    }

    return Scaffold(
      backgroundColor: kwhiteAlternateColor,
      appBar: AppBar(
        title: Text(
          'Registration',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: HomeScreenDrawer(),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                // CircleAvatar(
                //   radius: 40,
                //   backgroundColor: Colors.grey,
                //   backgroundImage: pickedimage != null
                //       ? (Image.file(pickedimage)).image
                //       : null,
                // ),
                // FlatButton.icon(
                //   onPressed: _pickImage,
                //   textColor: Theme.of(context).primaryColor,
                //   icon: Icon(Icons.image),
                //   label: Text('Shop Photo'),
                // ),
                TextFormField(
                  initialValue: _initialdata['shop_name'],
                  decoration: InputDecoration(
                    labelText: 'Shop Name',
                    icon: Icon(Icons.add_business),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['shop_name'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['address'],
                  decoration: InputDecoration(
                    labelText: 'Address',
                    icon: Icon(Icons.add_location_sharp),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['address'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['Landmark'],
                  decoration: InputDecoration(
                    labelText: 'Landmark',
                    icon: Icon(Icons.place),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['Landmark'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['fssai'],
                  decoration: InputDecoration(
                    labelText: 'FSSAI No.',
                    icon: Icon(Icons.confirmation_num),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['fssai'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['gst'],
                  decoration: InputDecoration(
                    labelText: 'GST No.',
                    icon: Icon(Icons.format_list_numbered_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['gst'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['capacity'],
                  decoration: InputDecoration(
                    labelText: 'Mess Capacity',
                    icon: Icon(Icons.reduce_capacity),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['capacity'] = val;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  initialValue: _initialdata['phone'],
                  maxLength: 10,
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
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: <Widget>[
                    Text('Whole day Open'),
                    Switch(
                      value: _isopen,
                      onChanged: (_) {
                        setState(() {
                          _isopen = !_isopen;
                        });
                      },
                    ),
                    Text('Monthly Subscribtion'),
                    Switch(
                      value: _ismonthly,
                      onChanged: (_) {
                        setState(() {
                          _ismonthly = !_ismonthly;
                        });
                      },
                    ),
                  ],
                ),
                Divider1(
                  title: 'Lunch Timing',
                ),
                TimeRange(
                  fromTitle: Text(
                    'From',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  toTitle: Text(
                    'To',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  titlePadding: 20,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black87),
                  activeTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  borderColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.transparent,
                  activeBackgroundColor: Theme.of(context).primaryColor,
                  firstTime: TimeOfDay(hour: 11, minute: 30),
                  lastTime: TimeOfDay(hour: 17, minute: 00),
                  timeStep: 30,
                  timeBlock: 30,
                  onRangeCompleted: (range) {
                    print(range.start.format(context));
                    print(range.end.format(context));
                    _initialdata['lunch_start'] = range.start.format(context);
                    _initialdata['lunch_end'] = range.end.format(context);
                  },
                ),
                Divider1(
                  title: 'Dinner Timing',
                ),
                TimeRange(
                  fromTitle: Text(
                    'From',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  toTitle: Text(
                    'To',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  titlePadding: 20,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.normal, color: Colors.black87),
                  activeTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  borderColor: Theme.of(context).primaryColor,
                  backgroundColor: Colors.transparent,
                  activeBackgroundColor: Theme.of(context).primaryColor,
                  firstTime: TimeOfDay(hour: 19, minute: 30),
                  lastTime: TimeOfDay(hour: 23, minute: 30),
                  timeStep: 30,
                  timeBlock: 30,
                  onRangeCompleted: (range) {
                    _initialdata['dinner_start'] = range.start.format(context);
                    _initialdata['dinner_end'] = range.end.format(context);
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text('Register'),
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
