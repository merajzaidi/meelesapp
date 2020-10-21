import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/menu.dart';

enum SingingCharacter { veg, nonveg }

/// This is the stateful widget that the main application instantiates.
class FoodTypeWidget extends StatefulWidget {
  FoodTypeWidget({Key key}) : super(key: key);

  @override
  _FoodTypeWidgetState createState() => _FoodTypeWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _FoodTypeWidgetState extends State<FoodTypeWidget> {
  SingingCharacter _character = SingingCharacter.veg;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Veg',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              )),
          leading: Radio(
            activeColor: Colors.white,
            value: SingingCharacter.veg,
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              Provider.of<Menu>(context, listen: false).type('Veg');
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Non-Veg',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          leading: Radio(
            activeColor: Colors.white,
            value: SingingCharacter.nonveg,
            groupValue: _character,
            onChanged: (SingingCharacter value) {
              setState(() {
                Provider.of<Menu>(context, listen: false).timing('Non-Veg');
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
