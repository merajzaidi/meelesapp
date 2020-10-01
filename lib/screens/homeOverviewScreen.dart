import 'package:flutter/material.dart';
import '../widgets/bottomNavigationBarHomePage.dart';
import '../widgets/homeScreenDrawer.dart';

class HomepageOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Meeles',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        drawer: HomeScreenDrawer(),
        bottomNavigationBar: NavigationBarBottom());
  }
}
