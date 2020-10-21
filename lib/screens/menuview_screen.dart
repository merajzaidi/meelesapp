import 'package:flutter/material.dart';
import 'package:meeles/constants/textThemeConstants.dart';
import 'package:provider/provider.dart';
import '../providers/menu.dart';
import '../constants/textThemeConstants.dart';

class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          Card(
              child: Column(
            children: <Widget>[
              Text(
                'Lunch',
                style: ktextTheme.bodyText1,
              ),
            ],
          )),
        ],
      ),
    ));
  }
}
