import 'package:flutter/material.dart';
import 'package:Meeles_Partner/providers/menu.dart';
import 'package:Meeles_Partner/screens/menuview_screen.dart';
import '../providers/menu.dart';
import 'package:provider/provider.dart';

class WeeklyMenuOverviewScreen extends StatelessWidget {
  static const routeName = '/weeklymenuoverviewscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: Weekdays.map(
          (days) => InkWell(
            onTap: () async {
              await Provider.of<Menu>(context, listen: false).dayweek(days.day);
              Navigator.of(context).pushNamed(CardVariant.routeName);
            },
            splashColor: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                days.day,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.7),
                    Theme.of(context).primaryColor,
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 3 / 2,
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
