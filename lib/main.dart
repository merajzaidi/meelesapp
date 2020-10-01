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
      debugShowCheckedModeBanner: false,
      title: 'Meels',
      theme: ThemeData.light().copyWith(
        primaryColor: kprimaryColor,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 3.0,
          textTheme: 
        )
      ),
      home: HomepageOverviewScreen(),
    );
  }
}
