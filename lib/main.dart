import 'package:flutter/material.dart';
import './screens/homeOverviewScreen.dart';
import './constants/colorConstants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meels',
      theme: ThemeData.light().copyWith(primaryColor: kprimaryColor),
      home: HomepageOverviewScreen(),
    );
  }
}
