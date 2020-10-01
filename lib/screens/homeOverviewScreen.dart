import 'package:flutter/material.dart';
import 'package:meeles/constants/colorConstants.dart';
import '../widgets/bottomNavigationBarHomePage.dart';
import '../widgets/homeScreenDrawer.dart';
import '../models/messDetails.dart';

class HomepageOverviewScreen extends StatelessWidget {
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(
          color: kwhiteAlternateColor,
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        title: Text(
          'Meeles',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: HomeScreenDrawer(),
      bottomNavigationBar: NavigationBarBottom(),
      //  body: Form(
      //    child: FormFiels,
      //  ),
    );
  }
}
