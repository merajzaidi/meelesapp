import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/customRadioButtons.dart';
import '../widgets/foodType.dart';
import '../providers/menu.dart';

class Updatemenu extends StatefulWidget {
  static const routeName = '/updatemenu';

  @override
  _UpdatemenuState createState() => _UpdatemenuState();
}

class _UpdatemenuState extends State<Updatemenu> {
  Map<String, dynamic> _initialdata = {
    'item1': '',
    'item2': '',
    'item3': '',
    'item4': '',
    'roti': '',
    'rice': '',
    'desert': '',
    'price': '',
  };
  final _formkey = GlobalKey<FormState>();
  Future<void> submit() async {
    if (!_formkey.currentState.validate())
      print('invalid');
    else {
      _formkey.currentState.save();
      Provider.of<Menu>(context, listen: false).addmenu(_initialdata);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Thali Gradients'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.blue,
                  ),
                  height: 120.0,
                  child: MyStatefulWidget(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.lightBlue,
                  ),
                  height: 120.0,
                  child: FoodTypeWidget(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _initialdata['item1'],
                  decoration: InputDecoration(
                    labelText: 'Item1',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['item1'] = val;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _initialdata['item2'],
                  decoration: InputDecoration(
                    labelText: 'Item2',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['item2'] = val;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _initialdata['item3'],
                  decoration: InputDecoration(
                    labelText: 'Item3',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    _initialdata['item3'] = val;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _initialdata['item4'],
                  decoration: InputDecoration(
                    labelText: 'Item4',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    _initialdata['item4'] = val;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _initialdata['roti'],
                  decoration: InputDecoration(
                    labelText: 'Roti Quantity',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['roti'] = val;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _initialdata['rice'],
                  decoration: InputDecoration(
                    labelText: 'Rice Type',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    _initialdata['rice'] = val;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _initialdata['desert'],
                  decoration: InputDecoration(
                    labelText: 'Desert',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (val) {
                    _initialdata['desert'] = val;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  initialValue: _initialdata['price'],
                  decoration: InputDecoration(
                    labelText: 'Price',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) return 'Required';
                  },
                  onSaved: (val) {
                    _initialdata['price'] = val;
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  onPressed: submit,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
