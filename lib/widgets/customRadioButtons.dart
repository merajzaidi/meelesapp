import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu.dart';

enum SingingCharacter { lunch, dinner }

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  SingingCharacter _character = SingingCharacter.lunch;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Lunch',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )),
          leading: Radio(
            activeColor: Colors.white,
            value: SingingCharacter.lunch,
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              Provider.of<Menu>(context, listen: false).timing('Lunch');
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Dinner',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          leading: Radio(
            activeColor: Colors.white,
            value: SingingCharacter.dinner,
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              Provider.of<Menu>(context, listen: false).timing('Dinner');
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
