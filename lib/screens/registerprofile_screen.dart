import 'package:flutter/material.dart';
import 'package:Meeles_Partner/widgets/divider.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import 'package:time_range/time_range.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int step = 1;
  bool _isopen = false, _getlocation = false;
  bool _ismonthly = false;
  String _servicetype = 'Mess';
  Map<int, String> typeService = {
    0: 'Mess',
    1: 'Tifin',
    2: 'Both',
  };
  File pickedimage;
  bool issaved = false;
  String dropdownValue = 'KIET College';
  Map<String, dynamic> _personal;
  Position position;
  Map<String, dynamic> _initialdata = {
      'Landmark': 'KIET College',
      'shop_name': '',
      'address': '',
      'fssai': '',
      'gst': '',
      'capacity': 0,
      'lunch_start': '',
      'lunch_end': '',
      'dinner_start': '',
      'dinner_end': '',
      'note1': null,
      'note2': null,
      'note3': null,
      'note4': null,
    };
    Map<String, dynamic> _initialdata2 = {
      'Name': '',
      'permanent_address': '',
      'phone': '',
      'adharcard': '',
      'city': '',
      'pincode': '',
    };
    
    final _form1key = GlobalKey<FormState>();
    final _form2key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    Future<void> submit() async {
      if (!_form1key.currentState.validate())
        print('invalid');
      else {
        _form1key.currentState.save();
        setState(() {
          step = 2;
        });
        setState(() {
          _personal = _initialdata2;
        });
        await Provider.of<Auth>(context, listen: false).addmenu('Create');
      }
    }

    Future<void> submit2() async {
      if (!_form2key.currentState.validate())
        print('invalid');
      else {
        _form2key.currentState.save();
        print(_initialdata);
        issaved = await Provider.of<Auth>(context, listen: false).addpersonal(
            _initialdata, _personal, _servicetype, _isopen, _ismonthly,position,pickedimage);
      }
    }

    void _pickImage() async {
      final pickedImageFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 10,
        maxWidth: 150,
      );
      setState(() {
        pickedimage = File(pickedImageFile.path);
      });
    }

  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    if (permission == LocationPermission.denied) {
      return Future.error(
          'Location permissions are denied');
    }
  }
  return await Geolocator.getCurrentPosition();
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
          child: step == 1
              ? Form(
                  key: _form1key,
                  child: Column(
                    children: <Widget>[
                      Divider1(
                        title: 'Enter your personal Details',
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata2['Name'],
                        decoration: InputDecoration(
                          labelText: 'Owner Name',
                          icon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value.isEmpty) return 'Required';
                        },
                        onSaved: (val) {
                          setState(() {
                            _initialdata2['Name'] = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata2['permanent_address'],
                        //focusNode: nodes[0],
                        decoration: InputDecoration(
                          labelText: 'Permanent Address',
                          icon: Icon(Icons.add_location_sharp),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty) return 'Required';
                        },
                        textCapitalization: TextCapitalization.words,
                        onSaved: (val) {
                          print(val);
                          setState(() {
                            _initialdata2['permanent_address'] = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata2['pincode'],
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
                          setState(() {
                            _initialdata2['pincode'] = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata2['city'],
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
                          setState(() {
                            _initialdata2['city'] = val;
                          });
                        },
                        textCapitalization: TextCapitalization.words,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata2['adharcard'],
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
                          setState(() {
                            _initialdata2['adharcard'] = val;
                          });
                        },
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata2['phone'],
                        maxLength: 10,
                        //focusNode: nodes[6],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Phone No.',
                          icon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty) return 'Required';
                        },
                        onSaved: (val) {
                          setState(() {
                            _initialdata2['phone'] = val;
                          });
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
                )
              : Form(
                  key: _form2key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider1(
                        title: 'Register your Shop',
                      ),
                      pickedimage != null
                          ? Center(
                            child: ClipOval(
                                // backgroundImage:
                                //     NetworkImage(document.data()['Upload Link']),
                                child: Image.file(pickedimage, width: 80, height: 80,fit: BoxFit.cover,),
                              ),
                          )
                          : Center(
                              child: CircleAvatar(
                                radius: 40,
                                child: Text('Update'),
                              ),
                            ),
                      Center(
                        child: FlatButton.icon(
                          onPressed: _pickImage,
                          textColor: Theme.of(context).primaryColor,
                          icon: Icon(Icons.image),
                          label: Text('Shop Photo'),
                        ),
                      ),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black54),
                        underline: Container(
                          height: 2,
                          color: Colors.black26,
                        ),
                        onChanged: (String newValue) {
                          _initialdata['Landmark'] = newValue;
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        items: <String>[
                          'KIET College',
                          'RKGIT College',
                          'SRM College',
                          'AKG College',
                          'Indraprasth College',
                          'Others'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata['shop_name'],
                        textCapitalization: TextCapitalization.words,
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
                          print(_initialdata['shop_name']);
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata['address'],
                        //focusNode: nodes[0],
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          icon: Icon(Icons.add_location_sharp),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty) return 'Required';
                        },
                        onSaved: (val) {
                          print(val);
                          _initialdata['address'] = val;
                          print(_initialdata['address']);
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        initialValue: _initialdata['fssai'],
                        //focusNode: nodes[3],
                        textCapitalization: TextCapitalization.words,
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
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          labelText: 'GST No.',
                          icon: Icon(Icons.format_list_numbered_outlined),
                          border: OutlineInputBorder(),
                        ),
                        //focusNode: nodes[4],
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
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Mess Capacity',
                          icon: Icon(Icons.reduce_capacity),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty) return 'Required';
                        },
                        //focusNode: nodes[5],
                        onSaved: (val) {
                          _initialdata['capacity'] = val;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service Type',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ToggleSwitch(
                            minHeight: 30.0,
                            fontSize: 16.0,
                            cornerRadius: 20.0,
                            initialLabelIndex: 0,
                            activeBgColor: Theme.of(context).primaryColor,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['Mess', 'Tifin', 'Both'],
                            onToggle: (index) {
                              _servicetype = typeService[index];
                              
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Whole day Open',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ToggleSwitch(
                            minWidth: 108.0,
                            minHeight: 30,
                            cornerRadius: 20.0,
                            activeBgColor: Theme.of(context).primaryColor,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['No', 'Yes'],
                            icons: [
                              FontAwesomeIcons.times,
                              FontAwesomeIcons.check,
                            ],
                            onToggle: (index) {
                              _isopen = !_isopen;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Monthly Plan',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ToggleSwitch(
                            minWidth: 108.0,
                            cornerRadius: 20.0,
                            minHeight: 30,
                            activeBgColor: Theme.of(context).primaryColor,
                            activeFgColor: Colors.white,
                            inactiveBgColor: Colors.grey,
                            inactiveFgColor: Colors.white,
                            labels: ['No', 'Yes'],
                            icons: [
                              FontAwesomeIcons.times,
                              FontAwesomeIcons.check,
                            ],
                            onToggle: (index) {
                              print('1 $_isopen');
                              _ismonthly = !_ismonthly;
                              print('2 $_isopen');
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
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
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
                          _initialdata['lunch_start'] =
                              range.start.format(context);
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
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
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
                          _initialdata['dinner_start'] =
                              range.start.format(context);
                          _initialdata['dinner_end'] =
                              range.end.format(context);
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Divider1(
                        title: 'Shop Coordinates',
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Get Current Location',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: _getlocation, 
                            onChanged: (value)async{
                              setState(() {
                                _getlocation = value;
                                
                              });
                              position = await _determinePosition();
                              print(position.latitude);
                              print(position.longitude);
                            }),
                        ],
                      ),
                            SizedBox(height:12),
                            Divider1(title:'Notes'),
                            SizedBox(height:12),
                            
                      TextFormField(
                        initialValue: _initialdata['note1'],
                        textCapitalization: TextCapitalization.words,
                        maxLength: 50,
                        
                        decoration: InputDecoration(
                          labelText: 'Note 1',
                          //icon: Icon(Icons.add_business),
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (val) {
                          _initialdata['note1'] = val;
                        },
                      ),      SizedBox(height:12),
                            
                      TextFormField(
                        initialValue: _initialdata['note2'],
                        textCapitalization: TextCapitalization.words,
                        maxLength: 50,
                        
                        decoration: InputDecoration(
                          labelText: 'Note 2',
                          //icon: Icon(Icons.add_business),
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (val) {
                          _initialdata['note2'] = val;
                        },
                      ),      SizedBox(height:12),
                            
                      TextFormField(
                        initialValue: _initialdata['note3'],
                        textCapitalization: TextCapitalization.words,
                        maxLength: 50,
                        
                        decoration: InputDecoration(
                          labelText: 'Note 3',
                          //icon: Icon(Icons.add_business),
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (val) {
                          _initialdata['note3'] = val;
                        },
                      ),      SizedBox(height:12),
                            
                      TextFormField(
                        initialValue: _initialdata['note4'],
                        textCapitalization: TextCapitalization.words,
                        maxLength: 50,
                        
                        decoration: InputDecoration(
                          labelText: 'Note 4',
                          //icon: Icon(Icons.add_business),
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (val) {
                          _initialdata['note4'] = val;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          child: Text('Register'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          onPressed: submit2,
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
