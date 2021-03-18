import 'package:Meeles_Partner/helpermethods/helpermethods.dart';
import 'package:Meeles_Partner/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:Meeles_Partner/constants/colorConstants.dart';
import 'package:Meeles_Partner/providers/screen.dart';
import 'package:provider/provider.dart';
import '../widgets/bottomNavigationBarHomePage.dart';
import '../widgets/homeScreenDrawer.dart';

class HomepageOverviewScreen extends StatefulWidget {
  static const routeName = '/homepageoverviewscreen';

  @override
  _HomepageOverviewScreenState createState() => _HomepageOverviewScreenState();
}

class _HomepageOverviewScreenState extends State<HomepageOverviewScreen> {
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        Provider.of<Auth>(context,listen: false).authlogout();
        break;
      case 'Settings':
        break;
    }
  }
  @mustCallSuper
  void initState(){
    print('State entered');
    HelperMethod().currentMessinfo();
  }

  @override
  Widget build(BuildContext context) {
    String titlename = Provider.of<Screen>(context).gettitle;
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
          titlename,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      drawer: HomeScreenDrawer(),
      bottomNavigationBar: NavigationBarBottom(),
      body: Consumer<Screen>(
        builder: (context, ss, _) => ss.page,
      ),
    );
  }
}
