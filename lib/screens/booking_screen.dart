import 'package:flutter/material.dart';
import '../widgets/orders.dart';
import 'package:intl/intl.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import './bookingdetails_screen.dart';
import 'package:provider/provider.dart';
import '../providers/menu.dart';

class BookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future scancode() async {
      String id = await scanner.scan();
      //String id = 'UBpmaWce4ORZnCNCfAH';
      var data =
          await Provider.of<Menu>(context, listen: false).updatestatus(id);
      Navigator.of(context)
          .pushNamed(Bookingdetails.routeName, arguments: data);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TabBar(
            labelStyle: TextStyle(
              fontFamily: 'Lato',
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'Lunch',
              ),
              Tab(
                text: 'Dinner',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Orders(
                type: 'Lunch',
                date: DateFormat.yMMMMEEEEd().format(DateTime.now())),
            Orders(
                type: 'Dinner',
                date: DateFormat.yMMMMEEEEd().format(DateTime.now())),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: scancode,
          child: Icon(Icons.aspect_ratio_outlined),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
