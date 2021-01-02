import 'package:flutter/material.dart';
import 'package:Meeles_Partner/screens/updatemenu_screen.dart';
import 'package:Meeles_Partner/widgets/menu.dart';
import '../widgets/menu.dart';
import '../constants/colorConstants.dart';
import 'package:provider/provider.dart';
import '../providers/menu.dart';

class CardVariant extends StatelessWidget {
  static const routeName = '/cardvariant';
  // static const id = 'CardVariant';
  // CollectionReference daymenu;
  String getday;
  @override
  Widget build(BuildContext context) {
    // final heightOne = MediaQuery.of(context).size.height;
    // daymenu = Provider.of<Menu>(context).snapshot;
    getday = Provider.of<Menu>(context).getday;
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(
          color: kwhiteAlternateColor,
        ),
        title: Text(
          'Menu',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: MenuWidget(
        getday: getday,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Updatemenu.routeName);
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
